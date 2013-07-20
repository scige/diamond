# coding: utf-8

Diamond::Application.routes.draw do
  devise_for :supers

  devise_for :editors

  resources :shops

  get "shops/map/:id" => "shops#map"

  resources :promos

  resources :coupons

  namespace :admin do
    resources :shops do
      get :map, :on => :collection
    end

    resources :promos

    resources :coupons

    resources :products

    resources :shop_promo_relationships

    resources :weixin_users
  end

  scope :path => "/weixin", :via => :post, :defaults => {:format => 'xml'} do
    #root :to => 'weixin/home#index', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'text' }

    root :to => 'weixin/weixin_users#subscribe', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'event' && request.params[:xml][:Event] == "subscribe" }

    root :to => 'weixin/weixin_users#unsubscribe', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'event' && request.params[:xml][:Event] == "unsubscribe" }

    root :to => 'weixin/shops#more', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'text' && request.params[:xml][:Content] = 'm' }

    root :to => 'weixin/shops#dingcan', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'text' && request.params[:xml][:Content].start_with?('dc ') }

    root :to => 'weixin/shops#index', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'text' }
  end

  get "/weixin" => "weixin/home#index"

  # root要放在最后
  root :to => 'home#index'
end

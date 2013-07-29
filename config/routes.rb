# coding: utf-8

Diamond::Application.routes.draw do
  devise_for :supers

  devise_for :editors

  resources :shops do
    get :map, :on => :collection
    get :phone, :on => :collection
  end

  resources :promos

  resources :coupons

  namespace :admin do
    resources :shops do
      get :map, :on => :collection
      get :search, :on => :collection
      get :not_verify, :on => :collection
      get :can_dingcan, :on => :collection
    end

    resources :promos

    resources :coupons

    resources :products do
      post :batch_create, :on => :collection
    end

    resources :shop_promo_relationships

    resources :weixin_users

    resources :categories

    resources :districts
  end

  resources :notices do
    get :help, :on => :collection
  end

  scope :path => "/weixin", :via => :post, :defaults => {:format => 'xml'} do
    #root :to => 'weixin/home#index', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'text' }

    root :to => 'weixin/weixin_users#subscribe', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'event' && request.params[:xml][:Event] == "subscribe" }

    root :to => 'weixin/weixin_users#unsubscribe', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'event' && request.params[:xml][:Event] == "unsubscribe" }

    root :to => 'weixin/home#help', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'text' && (request.params[:xml][:Content] == 'help' || request.params[:xml][:Content] == 'h') }

    root :to => 'weixin/shops#more', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'text' && (request.params[:xml][:Content] == 'm' || request.params[:xml][:Content] == 'M') }

    root :to => 'weixin/shops#dingcan', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'text' && request.params[:xml][:Content].index(/^[Dd][Cc]/) }

    root :to => 'weixin/shops#index', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'text' }
  end

  get "/weixin" => "weixin/home#index"

  # root要放在最后
  root :to => 'home#index'
end

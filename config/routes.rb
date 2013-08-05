# coding: utf-8

Diamond::Application.routes.draw do
  devise_for :supers

  devise_for :editors

  resources :shops do
    get :map, :on => :collection
    get :phone, :on => :collection
    get :follow, :on => :collection
    get :unfollow, :on => :collection
  end

  resources :promos

  resources :coupons

  resources :weixin_users do
    get :myhome, :on => :collection
  end

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
    root :to => 'weixin/weixin_users#subscribe', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'event' && request.params[:xml][:Event] == "subscribe" }

    root :to => 'weixin/weixin_users#unsubscribe', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'event' && request.params[:xml][:Event] == "unsubscribe" }

    root :to => 'weixin/weixin_users#bind', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'text' && request.params[:xml][:Content] == 'bind'}

    root :to => 'weixin/weixin_users#binding', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'text' && is_binding_finish?(request.params)}

    root :to => 'weixin/weixin_users#myhome', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'text' && (request.params[:xml][:Content] == 'my' || request.params[:xml][:Content] == 'My' || request.params[:xml][:Content] == 'MY') }

    root :to => 'weixin/home#help', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'text' && (request.params[:xml][:Content] == 'help' || request.params[:xml][:Content] == 'h') }

    root :to => 'weixin/shops#near', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'location' }

    root :to => 'weixin/shops#more', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'text' && (request.params[:xml][:Content] == 'm' || request.params[:xml][:Content] == 'M') }

    root :to => 'weixin/shops#dingcan', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'text' && request.params[:xml][:Content].index(/^[Dd][Cc]/) }

    root :to => 'weixin/shops#index', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'text' }
  end

  get "/weixin" => "weixin/home#index"

  # root要放在最后
  root :to => 'home#index'
end

def is_binding_finish?(params)
  weixin_user = WeixinUser.find_by_open_id(params[:xml][:FromUserName])
  if !weixin_user
    return false
  end
  return weixin_user.binding != Setting.weixin_user.binding_finish
end

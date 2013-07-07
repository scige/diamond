Diamond::Application.routes.draw do
  root :to => 'home#index'

  devise_for :supers

  resources :shops

  resources :promos

  resources :coupons

  namespace :admin do
    resources :shops do
      get :map, :on => :collection
    end

    resources :promos

    resources :coupons

    resources :shop_promo_relationships

    resources :weixin_users
  end

  scope :path => "/weixin", :via => :post, :defaults => {:format => 'xml'} do
    #root :to => 'weixin/home#index', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'text' }

    root :to => 'weixin/weixin_users#subscribe', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'event' && request.params[:xml][:Event] == "subscribe" }

    root :to => 'weixin/weixin_users#unsubscribe', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'event' && request.params[:xml][:Event] == "unsubscribe" }

    root :to => 'weixin/shops#index', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'text' && request.params[:xml][:Content].start_with?('@') }
  end

  get "/weixin" => "weixin/home#index"
end

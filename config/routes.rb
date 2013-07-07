Diamond::Application.routes.draw do
  root :to => 'home#index'

  devise_for :supers

  resources :shops

  resources :promos

  namespace :admin do
    resources :shops do
      get :map, :on => :collection
    end

    resources :promos

    resources :shop_promo_relationships

    resources :weixin_users
  end

  scope :path => "/weixin", :via => :post, :defaults => {:format => 'xml'} do
    root :to => 'weixin/home#index', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'text' }

    root :to => 'weixin/shops#index', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'text' && request.params[:xml][:Content].start_with?('@') }
  end

  get "/weixin" => "weixin/home#show"
end

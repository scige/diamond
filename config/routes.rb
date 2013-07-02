Diamond::Application.routes.draw do
  root :to => 'home#index'

  devise_for :supers

  resources :weixins

  resources :shops do
    get :map, :on => :collection
  end

  namespace :admin do
    resources :shops
  end
end

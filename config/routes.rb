Diamond::Application.routes.draw do
  root :to => 'home#index'

  devise_for :supers

  resources :weixins

  resources :shops

  resources :promos

  namespace :admin do
    resources :shops do
      get :map, :on => :collection
    end
  end
end

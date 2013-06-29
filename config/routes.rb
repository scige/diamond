Diamond::Application.routes.draw do
  root :to => 'home#index'

  resources :weixins

  resources :shops do
    get :map, :on => :collection
  end
end

Diamond::Application.routes.draw do
  root :to => 'home#index'

  resource :weixin
end

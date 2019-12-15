Rails.application.routes.draw do
  resources :stocks
  resources :items
  resources :locations
  resources :products
  resources :channels
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

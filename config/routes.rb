Rails.application.routes.draw do
  devise_for :sellers
  devise_for :users
  
  resources :welcome
  resources :products
  
  root 'products#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

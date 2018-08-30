Rails.application.routes.draw do
  resources :charges
  get 'seller_product' => 'products#seller_product', :as => 'seller_product'
  # devise_for :sellers
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations'}
  devise_for :sellers, controllers: { sessions: 'sellers/sessions', registrations: 'sellers/registrations'}
  root 'products#index'
  resources :welcome
  get 'carts/index'
  post 'carts/callback'
  resources :products
#  resources :carts
  resources :carts do
    get 'add_to_cart', on: :member
    post 'add_to_cart', on: :member
  end
  # get '/patients/:id', to: 'patients#show', as: 'patient'
resources :orders do

  get 'placed_order', on: :member
  #  resources :orders do
  #   get 'placed_order', on: :member
  #   post 'placed_order', on: :member
  # end
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

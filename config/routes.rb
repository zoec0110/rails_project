Rails.application.routes.draw do
  get 'sessions/new'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users do
    collection do
      get :sign_in
      post :sign_in_create
      get :sign_up
      post :sign_up_create
    end
  end

  resources :lists do
    resources :stocks, controller: 'list_stocks'
    member do
      post :move_up
      post :move_down
    end
  end
  root 'users#sign_in'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  # Defines the root path route ("/")
  # root "articles#index"
end

# class User::OrdersController < ApplicationController
#   def index
#     @user = User.find(params[:user_id])
#     @orders = @user.orders
#   end

#   def destroy; end
# end

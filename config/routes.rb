Rails.application.routes.draw do
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
end

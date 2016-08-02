Rails.application.routes.draw do

  root 'users#home'

  devise_for :users, controllers:{
    registrations: 'registrations',
    sessions: 'sessions'
  }

  resources :users do
    post :subscribe_to_users
  end

  resources :messages do
    collection { get :events }
  end

end
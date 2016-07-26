Rails.application.routes.draw do

  devise_for :users, controllers:{
    registrations: 'registrations',
    sessions: 'sessions',
    confirmations: 'confirmations',
    passwords: 'passwords',
    unlocks: 'unlocks'
  }
  root 'users#home'

  resources :messages do
    collection { get :events }
  end
  # root to: 'messages#index'



end

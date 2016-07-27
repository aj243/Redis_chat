Rails.application.routes.draw do

  root 'users#home'

  devise_for :users, controllers:{
    registrations: 'registrations',
    sessions: 'sessions',
    confirmations: 'confirmations',
    passwords: 'passwords',
    unlocks: 'unlocks'
  }

  resources :users do
    post :subscribe_to_users
  end

  resources :messages do
    collection { get :events }
  end

end


# resources :users do
#     collection do
#       resources :orders, only: [:show, :index, :edit, :destroy] do
#         get 'cancel_order', to: 'orders#cancel_order'
#         get 'revert_order_state', to: 'orders#revert_order_state'
#       end
      
#       resources :user_profiles, only: [:new, :create]

#       post :search_shop
#       get :about
#       get :contact
#       get :easy_registration

#       resources :shop_profiles, only: [:new, :create, :index, :show] do
#         get :edit, on: :member
#         put :update, on: :member
#         resources :shipping_charges, only: [:new, :create, :edit, :update] do
#           get :reset, on: :collection
#         end  
#         resources :shop_products do
#           post :add_product_manually,to: 'shop_products#add_product_manually',on: :collection
#         end
#       end

#       resources :addresses, only: [:new, :create, :edit, :update, :index , :destroy] 

#       get 'profile', to: 'users#profile'

#       resources :user_baskets, only: [:edit, :update, :destroy] do
#         get :create, on: :member
#         get :edit_quantity ,on: :member
#         put :update_quantity , on: :member
#       end
#     end
#   end

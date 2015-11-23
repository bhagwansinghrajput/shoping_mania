Rails.application.routes.draw do
  get 'admin/index'

  get 'home/index'

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
 
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  resources :admin do
    collection do
      get 'all_users', :path => "/users"
      get 'all_buyers', :path => "/buyers"
    end 
    member do
      post :permit_for_add_items
    end
  end 
  resources :users do
    member do
      put  :toggle
      post :permit_for_add_items
    end
  end
  resources :buyers
  resources :products do
    member do
      get 'all_orders'
      get 'product_by_categories'
    end
    collection do
      get 'search'
      get :autocomplete_category_name
    end  
  end
  resources :categories
  resources :cart
  resources :cart_item
  resources :orders
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
    # resources :users do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

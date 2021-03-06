Bplan::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static_pages#index'

  resources :users
  resources :favorite_events do
    get 'redefine', on: :collection
  end

  # sign up link
  match '/signup', to: 'users#new', via: 'get'

  get '/favorite', to: 'events#favorite', via: 'post'

  get '/logout' => 'users#logout', as: :logout
  get '/login' => 'users#login', as: :login
  post '/login' => 'users#login_post'

  
  get '/preferences' => 'users#preferences', as: :preferences
  post '/groups' => 'users#update_groups', as: :update_groups
  post '/reminders' => 'users#update_reminders', as: :update_reminders

  get '/reminders' => 'users#reminders', as: :reminders
  
  post '/update_favs' => 'favorite_events#update', as: :update_favs
  
  get '/user_groups' => 'users#user_groups'

  get '/about' => 'static_pages#about', as: :about

  post '/test_email' => 'users#test_email', as: :test_email
  post '/test_sms' => 'users#test_sms', as: :test_sms

  get '/events/:id' => 'events#show', as: :show_event
  
  # Example of regular route:
  # get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
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

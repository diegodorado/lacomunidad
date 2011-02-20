Lacomunidad::Application.routes.draw do
  resources :authentications
  match '/auth/:provider/callback' => 'authentications#create'

  devise_for :users, :controllers => {:registrations => 'registrations'}

  # The priority is based upon order of creation:
  # first created -> highest priority.

  root :to => "home#index"

  match '/que-es' => 'what#index'
  match '/muro/mas/:offset' => 'wall#view_more_posts', :as => 'wall_view_more_posts'
  match '/muro' => 'wall#index'

  match '/create_post_og' => 'wall#create_post_og', :as => 'create_post_og'

  match '/publicar' => 'wall#create_post', :as => 'new_post'
  match '/comentar/:post_id' => 'wall#create_comment', :as => 'new_comment'
  match '/noticias' => 'news#index'
  match '/documentos' => 'docs#index'
  match '/como-participar' => 'participate#index'
  match '/profile' => 'users#profile', :as => 'profile'
  
  resources :posts
  
  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)


  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  #match ':controller(/:action(/:id(.:format)))'
end

Lacomunidad::Application.routes.draw do

  #static pages
  root :to => "static#home"
  match '/que-es' => 'static#what', :as => 'what'
  match '/noticias' => 'static#news'
  match '/documentos' => 'static#docs'
  match '/como-participar' => 'static#participate', :as => 'participate'

  #users
  devise_for :users
  resources :users, :only => [:index]
  resources :authentications
  match '/auth/:provider/callback' => 'authentications#create'
  match '/profile' => 'users#profile', :as => 'profile'
  match '/profile_pic/:provider' => 'users#profile_pic', :as => 'profile_pic'
  match '/profile_name/:name' => 'users#profile_name', :as => 'profile_name'

  #wall
  match '/muro' => 'wall#index'

  #posts
  resources :posts, :only => [:index, :create, :destroy] do
    resources :comments, :only => [:create, :destroy]
    get 'opengraph'
    member do
      post 'vote'
    end    
  end

  #pages
  resources :pages, :except => [:new, :create]
  post '/pages/new' => 'pages#new', :as => 'new_page'

end

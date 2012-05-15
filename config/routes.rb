Lacomunidad::Application.routes.draw do

  resources :audios
  resources :books
  resources :videos
  resources :candidates
  resources :candidates do
    get 'votes_result', :on => :collection  
    member do
      get 'vote'
      get 'unvote'
    end    
  end
  
  resources :settings, :only => [:index]
  

  #static pages
  root :to => "static#home"
  match '/que-es' => 'static#what', :as => 'what'
  match '/noticias' => 'static#news'
  match '/documentos' => 'static#docs', :as => 'docs'
  match '/documentos/videos' => 'static#docs_videos', :as => 'docs_videos'
  match '/documentos/libros' => 'static#docs_books', :as => 'docs_books'
  match '/documentos/experiencias-guiadas' => 'static#docs_xgs', :as => 'docs_xgs'
  match '/como-participar' => 'static#participate', :as => 'participate'

  #users
  resources :users, :only => [:index] do
    member do
      #get 'toggle_role/:role' => "users#toggle_role", :as => 'toggle_role'
      get 'profile' => "users#profile"
      get 'toggle_role'
      get 'change_pic'
      get 'change_name'
    end    
  end
  devise_for :users
  resources :authentications
  match '/auth/:provider/callback' => 'authentications#create'

  #wall
  match '/muro' => 'wall#index'

  #posts
  resources :posts, :only => [:index, :create, :destroy] do
    resources :comments, :only => [:create, :destroy]
    member do
      post 'vote'
    end    
  end
  
  post '/opengraph' => 'opengraph#index', :as => 'opengraph'

  #pages
  resources :pages, :except => [:create] do
    post 'new', :on => :collection
  end

end

Lacomunidad::Application.routes.draw do

  #static pages
  root :to => "static#home"
  match '/que-es' => 'static#what', :as => 'what'
  match '/noticias' => 'static#news'
  match '/documentos' => 'static#docs'
  match '/como-participar' => 'static#participate', :as => 'participate'

  #users
  resources :authentications
  match '/auth/:provider/callback' => 'authentications#create'
  devise_for :users, :controllers => {:registrations => 'registrations'}
  match '/profile' => 'users#profile', :as => 'profile'

  #wall
  match '/wall2' => 'wall#index2'
  match '/muro' => 'wall#index'
  match '/muro/mas/:offset' => 'wall#view_more_posts', :as => 'wall_view_more_posts'
  match '/create_post_og' => 'wall#create_post_og', :as => 'create_post_og'
  match '/publicar' => 'wall#create_post', :as => 'new_post'
  match '/comentar/:post_id' => 'wall#create_comment', :as => 'new_comment'
  match '/view_post_comments/:post_id' => 'wall#view_post_comments', :as => 'wall_view_post_comments'
  match '/vote_post/:post_id/:direction' => 'wall#vote_post', :as => 'wall_vote_post'

  #pages
  resources :pages, :except => [:new, :create]
  post '/pages/new' => 'pages#new', :as => 'new_page'

end

Lacomunidad::Application.routes.draw do

  root :to => "home#index"

  resources :authentications
  match '/auth/:provider/callback' => 'authentications#create'

  devise_for :users, :controllers => {:registrations => 'registrations'}


  match '/que-es' => 'what#index', :as => 'what'
  match '/noticias' => 'news#index'
  get '/noticias/:path' => 'news#show', :as => 'show_news'
  match '/documentos' => 'docs#index'
  match '/como-participar' => 'participate#index', :as => 'participate'

  #wall
  match '/muro/mas/:offset' => 'wall#view_more_posts', :as => 'wall_view_more_posts'
  match '/muro' => 'wall#index'
  match '/create_post_og' => 'wall#create_post_og', :as => 'create_post_og'
  match '/publicar' => 'wall#create_post', :as => 'new_post'
  match '/comentar/:post_id' => 'wall#create_comment', :as => 'new_comment'
  match '/view_post_comments/:post_id' => 'wall#view_post_comments', :as => 'wall_view_post_comments'
  match '/vote_post/:post_id/:direction' => 'wall#vote_post', :as => 'wall_vote_post'

  match '/profile' => 'users#profile', :as => 'profile'
  
  #pages
  resources :pages, :except => [:index]

end

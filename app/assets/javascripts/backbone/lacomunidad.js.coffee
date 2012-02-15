#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views

window.Lacomunidad =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  
  
class Application
  constructor: ->
    @models = {}
    @collections = {}
    @views = {}
    @utils = {}
    
  load: (options) ->
    jQuery =>
      @onReadyLoad options
      
  
  onReadyLoad: (options) ->
    #set users
    @users = new Lacomunidad.Collections.UsersCollection options.users
    @user_id = options.user_id
    @user = app.users.user_or_guest(@user_id)

    if options.wall
      @posts = new Lacomunidad.Collections.PostsCollection()
      #todo: reset from options instead of fetching
      @posts.fetch()
    if options.chat
      @views.chat = new Lacomunidad.Views.ChatView
      @views.chat.render()
    if options.videos
      @views.docs = new Lacomunidad.Views.DocsView
      @views.docs.render()
      @videos = new Lacomunidad.Collections.VideosCollection()
      @videos.reset options.videos
    if options.pages_edit
      @Pages.init()


window.app = new Application
  

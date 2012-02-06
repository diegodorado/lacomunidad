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
    jQuery =>
      @initialize this

  onReady: -> null  

  initialize: ->
    @users = new Lacomunidad.Collections.UsersCollection()
    @posts = new Lacomunidad.Collections.PostsCollection()
    @views.wall = new Lacomunidad.Views.WallView
    @views.wall.render()
    
  load: (options) ->
    @users.reset options.users
    @current_user = @users.get options.current_user_id
    #todo: initialize from options
    @posts.fetch()


window.app = new Application
  

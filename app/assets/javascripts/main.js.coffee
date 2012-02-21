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
    @utils = 
      format: (text) ->
        url_pattern = /(\b(https?):\/\/[\-A-Z0-9+&@#\/%?=~_|!:,.;]*[\-A-Z0-9+&@#\/%=~_|])/ig
        text = text.replace url_pattern, "<a class='autolink' href='$1' target='_blank'>$1</a>"    
        text.replace '\n' , "<br/>"
    @options = {}
    
  load: (options) ->
    for key, val of options
      @options[key] = val
      
  start: ->
    $(document).ajaxStart -> $('#ajax-indicator').show()
    $(document).ajaxStop ->  $('#ajax-indicator').hide()
    #todo: should do better than this
    $(document).ajaxError ->  $('#ajax-indicator').hide()
    jQuery => @onReadyLoad()
  
  onReadyLoad: ->
    #set users
    @users = new Lacomunidad.Collections.UsersCollection @options.users
    @user_id = @options.user_id
    @user = app.users.user_or_guest(@user_id)

    if @options.posts
      @posts = new Lacomunidad.Collections.PostsCollection()
      @views.wall = new Lacomunidad.Views.WallView {collection: @posts}
      @views.wall.render()
      @posts.reset @options.posts

    if @options.chat
      @views.chat = new Lacomunidad.Views.ChatView
      @views.chat.render()
    if @options.videos
      @videos = new Lacomunidad.Collections.VideosCollection()
      @views.docs = new Lacomunidad.Views.DocsView
      @views.docs.render()
      @videos.reset @options.videos
    if @options.page_edit
      App.Pages.initEditor()
    if @options.profile
      @initProfile()

  #todo: move over      
  initProfile: ->
    $("a.profile_pic").each () ->
      $(this).tooltip {placement: 'right',title: 'usar como imagen de perfil'}
    $("#name").editInPlace
      callback: (oe, html, ori) ->
        if html
          window.location = Routes.profile_name_path html
        else
          html = ori
        html


window.app = new Application  

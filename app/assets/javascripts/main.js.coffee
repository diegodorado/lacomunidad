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
      num_to_s: (num) ->
        num = num + ''
        num = '0' + num if num.length is 1
        num
      seconds_to_s: (seconds) ->
        minutes = @num_to_s(Math.floor seconds/60)
        seconds = @num_to_s(Math.round seconds % 60)
        minutes + ':' + seconds
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
      $('#videos_carousel').carousel({interval: 1000000000}) #long interval for no cycle
      $('#videos_carousel').bind 'slide', (event)->
        $('#videos_carousel .embed').css 'opacity', 0.1
      $('#videos_carousel').bind 'slid', (event)->
        $('#videos_carousel .embed').css 'opacity', 1
      $('#videos_list a').click (event) ->
        event.preventDefault()
        index = parseInt $(this).attr('data-index')
        #reset iframe
        $('#videos_carousel .active .embed').html $('#videos_carousel .active .embed').html()
        $('#videos_carousel').carousel index
    if @options.books
      $('#books_carousel').carousel({interval: 1000000000}) #long interval for no cycle
      $('#books_list a').click (event) ->
        event.preventDefault()
        index = parseInt $(this).attr('data-index')
        $('#books_carousel').carousel index
    if @options.xgs
      $("#xg_player .controls .download").tooltip()

      @xg_player = jwplayer('xg_player_swf').setup
        flashplayer: '/jwplayer/player.swf'

      @xg_player.load @options.xgs

      @xg_player.onTime (event) =>
        percent = Math.round((event.position/event.duration)*10000)/100
        $('#xg_player .progress .bar').css 'width', percent+'%'
        $('#xg_player .controls .time').html "#{@utils.seconds_to_s event.position} / #{@utils.seconds_to_s event.duration}"

      @xg_player.onPlaylistItem (event) =>
        $('#xg_player .playlist li').removeClass 'active'
        $('#xg_player .playlist li a[data-index='+event.index+']').closest('li').addClass 'active'
        xg = @options.xgs[event.index]
        $('#xg_player .current h3').html xg.title
        $('#xg_player .current p').html xg.description


      #@xg_player.onComplete (event) =>
      #@xg_player.onBufferChange (event) =>

      @xg_player.onPlay (event) =>
        $('#xg_player').addClass 'playing'

      @xg_player.onPause (event) =>
        $('#xg_player').removeClass 'playing'


      #todo: bind a single event  
      $('#xg_player .controls .prev').click (event) =>
        event.preventDefault()
        @xg_player.playlistPrev()
      $('#xg_player .controls .play').click (event) =>
        event.preventDefault()
        @xg_player.play() #actually, toggles
      $('#xg_player .controls .next').click (event) =>
        event.preventDefault()
        @xg_player.playlistNext()

      $('#xg_player .playlist a').click (event) =>
        event.preventDefault()
        index = parseInt $(event.target).attr('data-index')
        @xg_player.playlistItem(index)



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

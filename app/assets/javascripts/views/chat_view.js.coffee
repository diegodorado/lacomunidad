#= require 'swfobject'

class Lacomunidad.Views.ChatView extends Backbone.View
  template: JST["templates/chat"]
  sys_msg_template: JST["templates/chat/sys_msg"]
  el: '#chat_viewport'
  server_url: 'http://lacomunidad-chat.herokuapp.com:80/'
  events:
    'submit .send': 'send_message'
    'click .chat_title': 'toggle'
    'click .icon-trash': 'clear_log'
    
    
  cache:
    open: false
    messages: []
    
  initialize: ->
    #gets cache and attachs handler to save it on page unload
    @cache = store.get('chat-cache') or @cache
    $(window).unload () =>
      store.set('chat-cache', @cache)
  
  render: ->
    $(this.el).html @template()
    @update_from_cache()
    @$(".icon-trash").tooltip { placement: 'left'}    
    @

  update_from_cache: ->
    @render_user_message m for m in @cache.messages
    @open() if @cache.open
  
  initSocket: ->
    $.getScript @server_url+"socket.io/socket.io.js", @socketIoLoaded
    @createBeepPlayer()

  socketIoLoaded: =>
    @socket = io.connect @server_url
    @socketBinds()
    @key =  $('meta[name=csrf-token]').attr('content')
    @socket.emit 'load', @key, app.user_id

  createBeepPlayer: ->
    player_id = 'chat-mp3-player'
    #create flash listener
    @Mp3PlayerListener = 
      onInit: () =>
        #console.log 'init'
        @player.SetVariable "method:setUrl", "/assets/beep.mp3"
      onUpdate: () =>
        #console.log 'onUpdate'
    
    flashvars =
      listener: "app.views.chat.Mp3PlayerListener"
      interval: "500"
    params = 
      menu: "false"
      allowscriptaccess: 'always'
    attrs =
      id: player_id

    swfobject.embedSWF "/assets/player_mp3_js.swf", player_id, "1", "1", "9.0.0","expressInstall.swf", flashvars, params, attrs, (e) =>
      @player = @$("##{e.id}")[0]

  beep: ->
    #only beep if player is initialized and chat isnt focused
    @player?.SetVariable?("method:play", "") unless @$(".send input").is(":focus")

    
  socketBinds: ->
    @socket.on 'connect', @connect
    @socket.on 'reconnecting',  @reconnecting
    @socket.on 'reconnect',  @reconnect
    @socket.on 'error',  @error
    @socket.on 'user list changed',  @user_list_changed
    @socket.on 'user message', @user_message
    @socket.on 'user connected', @user_connected
    @socket.on 'user disconnected', @user_disconnected
      
  user_list_changed: (user_list) =>    
    @user_list = user_list
    view = new Lacomunidad.Views.Chat.LoggedUsersView user_list
    @$('.users').html view.render().el

  connect: => 
    @unblock_ui()
    
  reconnecting: =>
    @system_message 'Intentando reconectar con el servidor'
    @block_ui()
    
  reconnect: =>
    @unblock_ui()
    @system_message 'Hemos vuelto!'
    @socket.emit 'load', @key, app.user_id

  block_ui: ->
    @$('#chat').removeClass 'connected'
    
  unblock_ui: ->
    @$('#chat').addClass 'connected'

  open: ->
    @$('#chat').addClass 'in'
    @cache.open = true
    @initSocket() unless @socket
    

  close: ->
    @$('#chat').removeClass 'in'
    @cache.open = false

  toggle: (event) ->
    if @$('#chat').hasClass('in') then @close() else @open()
    
  error: (e)=>
    @system_message(e ? e : 'Ahhhhhhhhh...no esperaba este error!')  
    
  system_message: (msg) ->
    @render_message @sys_msg_template {message:msg}

  user_connected: (key) =>
    user_hash = @user_list[key]  
    user = app.users.user_or_guest(user_hash.user_id)
    @system_message "#{user.get('name')} se conectó."

  user_disconnected: (key) =>
    user_hash = @user_list[key]  
    user = app.users.user_or_guest(user_hash.user_id)
    @system_message "#{user.get('name')} se desconectó."

  user_message: (key, msg) =>
    @beep()    
    @log_user_message key, msg

  log_user_message: (key, msg) =>
    user_hash = @user_list[key]  
    user = app.users.user_or_guest(user_hash?.user_id)
    data = {user: user.toJSON(), message: msg}
    #save history
    @cache.messages.push data
    @render_user_message data

  clear_log: (event)->
    @$('.messages').empty()
    @cache.messages = []
  
  render_user_message: (data) ->
    view = new Lacomunidad.Views.Chat.UserMessageView data
    @render_message view.render().el

  render_message: (html) ->
    @$('.messages').append html
    @$('.messages').get(0).scrollTop = 10000000

  send_message: (event) ->
    event.preventDefault()
    msg = @$('.send input').val()
    return unless msg
    @log_user_message @key, msg
    @socket.emit 'user message', msg
    @$('.send input').val('').focus()


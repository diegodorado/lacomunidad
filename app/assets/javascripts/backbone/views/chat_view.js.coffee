class Lacomunidad.Views.ChatView extends Backbone.View
  template: JST["backbone/templates/chat"]
  sys_msg_template: JST["backbone/templates/chat/sys_msg"]
  el: '#chat_viewport'
  server_url: 'http://lacomunidad-chat.herokuapp.com:80/'
  events:
    'submit .send': 'send_message'
    'click .chat_title': 'toggle_chat'


  render: ->
    $(this.el).html @template()
    #@server_url = 'http://localhost:8000/'
    @initSocket()
    @


  initSocket: ->
    $.getScript @server_url+"socket.io/socket.io.js", @socketIoLoaded

  socketIoLoaded: =>
    @socket = io.connect @server_url
    @socketBinds()
    @key =  $('meta[name=csrf-token]').attr('content')
    @socket.emit 'load', @key, app.user_id
    
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

  connect:  =>
    @toggle true
    
  reconnecting: =>
    @system_message('Intentando reconectar con el servidor')
    @toggle false
    
  reconnect: =>
    @toggle true
    @system_message('Hemos vuelto!', true)
    @socket.emit 'load', @key, app.user_id

  toggle: (connected)->
    if connected
      @$('#chat').addClass 'connected'
    else
      @$('#chat').removeClass 'connected'
    
  error: (e)=>
    @system_message(e ? e : 'Ahhhhhhhhh...no esperaba este error!')  
    
  system_message: (msg, clear=false) ->
    @$('.messages').empty() if clear
    @$('.messages').append @sys_msg_template {message:msg}

  user_connected: (key) =>
    user_hash = @user_list[key]  
    user = app.users.user_or_guest(user_hash.user_id)
    @system_message "#{user.get('name')} se conectó."

  user_disconnected: (key) =>
    user_hash = @user_list[key]  
    user = app.users.user_or_guest(user_hash.user_id)
    @system_message "#{user.get('name')} se desconectó."

  user_message: (key, msg) =>
    user_hash = @user_list[key]  
    user = app.users.user_or_guest(user_hash.user_id)
    view = new Lacomunidad.Views.Chat.UserMessageView {user: user.toJSON(), message: msg}
    @$('.messages').append view.render().el



  toggle_chat: (event) ->
    @$('#chat').toggleClass('in')

  send_message: (event) ->
    event.preventDefault()
    msg = @$('.send input').val()
    return unless msg
    @user_message @key, msg
    @socket.emit 'user message', msg
    @$('.send input').val('').focus()
    @$('.messages').get(0).scrollTop = 10000000


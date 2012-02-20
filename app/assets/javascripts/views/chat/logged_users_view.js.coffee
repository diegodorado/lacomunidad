Lacomunidad.Views.Chat ||= {}

class Lacomunidad.Views.Chat.LoggedUsersView extends Backbone.View
  template: JST["templates/chat/logged_users"]
  item_template: JST["templates/chat/logged_user"]
  className: 'logged_users'

  initialize:(user_list) ->
    @user_list = user_list

  render: ->
    $(this.el).html @template()
    for key, user_hash of @user_list
      user = app.users.user_or_guest(user_hash.user_id)
      @$('ul').append @item_template user.toJSON()
    @$(".avatar").tooltip { placement: 'bottom'}
    @

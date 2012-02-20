Lacomunidad.Views.Chat ||= {}

class Lacomunidad.Views.Chat.UserMessageView extends Backbone.View
  template: JST["templates/chat/user_message"]
  className: 'user_message message'

  initialize: (data) ->
    @data =  data

  render: ->
    $(this.el).html @template @data
    @$(".avatar").tooltip { placement: 'left'}
    @

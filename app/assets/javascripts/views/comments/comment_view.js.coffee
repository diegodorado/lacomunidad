Lacomunidad.Views.Comments ||= {}

class Lacomunidad.Views.Comments.CommentView extends Backbone.View
  template: JST["templates/comments/comment"]
  tagName: 'li'
  className: 'comment fade'

  events:
    'click .destroy_comment': 'destroy_click'

  destroy_click: (event) ->
    event.preventDefault()
    @model.destroy()
    $(@el).removeClass('in')
    setTimeout (()=>$(@el).remove()), 500

  render: ->
    $(@el).html @template comment: @model.toJSON(), user: app.users.get(@model.get('user_id')).toJSON()
    setTimeout (()=>$(@el).addClass('in')), 500
    @

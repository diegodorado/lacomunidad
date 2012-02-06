Lacomunidad.Views.Comments ||= {}

class Lacomunidad.Views.Comments.CommentView extends Backbone.View
  template: JST["backbone/templates/comments/comment"]
  tagName: 'li'
  className: 'comment'

  events:
    'click .delete': 'delete'

  delete: ->
    @model.destroy()
    $(@el).remove()

  render: ->
    $(@el).html @template @model.toJSON()
    @

Lacomunidad.Views.Posts ||= {}

class Lacomunidad.Views.Posts.AttachementView extends Backbone.View
  template: JST["backbone/templates/posts/attachement"]
  className: 'attachement'

  render: ->
    $(this.el).html @template @model.toJSON()
    @

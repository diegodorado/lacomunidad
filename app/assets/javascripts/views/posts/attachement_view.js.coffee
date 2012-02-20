Lacomunidad.Views.Posts ||= {}

class Lacomunidad.Views.Posts.AttachementView extends Backbone.View
  template: JST["templates/posts/attachement"]
  className: 'post_attach'

  events:
    'click a.show-embed': 'click'

  click: (event) ->
    if @model.get 'embed'
      event.preventDefault()
      $(this.el).html @model.get 'embed'

  render: ->
    $(this.el).html @template @model.toJSON()
    @

Lacomunidad.Views.Videos ||= {}

class Lacomunidad.Views.Videos.MiniVideoView extends Backbone.View
  template: JST["templates/videos/mini_video"]
  tagName: 'li'
  className: 'span3'



  events:
    'click .thumbnail': 'thumbnail_click'

  thumbnail_click: (event)->
    event.preventDefault()
    app.views.docs.selectVideo @model
    
  render: ->
    $(this.el).html @template @model.toJSON()
    @

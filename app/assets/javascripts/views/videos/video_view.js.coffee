Lacomunidad.Views.Videos ||= {}

class Lacomunidad.Views.Videos.VideoView extends Backbone.View
  template: JST["templates/videos/video"]

  render: ->
    $(this.el).html @template @model.toJSON()
    @

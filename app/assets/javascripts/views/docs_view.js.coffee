class Lacomunidad.Views.DocsView extends Backbone.View
  template: JST["templates/docs"]
  el: '#docs_videos'

  initialize: ->
    app.videos.bind('reset', @addVideos)

  addVideos: =>
    app.videos.each(@addVideo)
    @selectVideo app.videos.at 0

  addVideo: (video) =>
    view = new Lacomunidad.Views.Videos.MiniVideoView({model : video})
    @$("#mini_videos").append view.render().el

  selectVideo: (video) ->
    view = new Lacomunidad.Views.Videos.VideoView({model : video})
    @$("#video").html view.render().el


  render: ->
    $(this.el).html(@template())
    @

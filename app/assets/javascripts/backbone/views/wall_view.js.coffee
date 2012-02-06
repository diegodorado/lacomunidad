class Lacomunidad.Views.WallView extends Backbone.View
  template: JST["backbone/templates/wall"]
  el: '#wall_viewport'

  initialize: ->
    app.posts.bind('reset', @addPosts)

  addPosts: =>
    app.posts.each(@addPost)

  addPost: (post) =>
    view = new Lacomunidad.Views.Posts.PostView({model : post})
    @$("#posts > ul").append view.render().el

  render: ->
    $(this.el).html(@template())
    view = new Lacomunidad.Views.Posts.NewPostView
    @$("#new_post").html view.render().el
    @

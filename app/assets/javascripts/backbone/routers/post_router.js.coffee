class Lacomunidad.Routers.PostsRouter extends Backbone.Router
  initialize: (options) ->
    @posts = new Lacomunidad.Collections.PostsCollection()
    @posts.reset options.posts

  routes:
    "/show": "show"
    ""        : "list"

  list: ->
    @view = new Lacomunidad.Views.Posts.ListView(posts: @posts)
    $("#posts").html(@view.render().el)

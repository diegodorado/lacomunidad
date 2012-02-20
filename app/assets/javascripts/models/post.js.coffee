class Lacomunidad.Models.Post extends Backbone.Model
  paramRoot: 'post'

class Lacomunidad.Collections.PostsCollection extends Backbone.Collection
  model: Lacomunidad.Models.Post
  url: ->
    window.Routes.posts_path()

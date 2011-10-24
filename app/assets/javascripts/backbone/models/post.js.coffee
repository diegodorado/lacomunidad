class Lacomunidad.Models.Post extends Backbone.Model
  paramRoot: 'post'

  defaults:
    id: null
    body: null
    user_id: null

class Lacomunidad.Collections.PostsCollection extends Backbone.Collection
  model: Lacomunidad.Models.Post
  #url: '/posts'

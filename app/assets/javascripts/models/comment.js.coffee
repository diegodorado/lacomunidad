class Lacomunidad.Models.Comment extends Backbone.Model
  paramRoot: 'comment'

class Lacomunidad.Collections.CommentsCollection extends Backbone.Collection
  model: Lacomunidad.Models.Comment
  
  initialize: (options)->
    @post_id = options.post_id
    @reset options.comments
  
  url: ->
    window.Routes.post_comments_path @post_id

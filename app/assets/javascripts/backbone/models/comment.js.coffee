class Lacomunidad.Models.Comment extends Backbone.Model
  paramRoot: 'comment'

  toJSON: ->
    r = _.clone @attributes
    r.user = (app.users.get @get 'user_id').toJSON() if @get 'user_id'
    delete r[key] for key in ['user_id']
    r

class Lacomunidad.Collections.CommentsCollection extends Backbone.Collection
  model: Lacomunidad.Models.Comment
  
  initialize: (options)->
    @post_id = options.post_id
    @reset options.comments
  
  url: ->
    window.Routes.post_comments_path @post_id

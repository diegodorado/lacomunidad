class Lacomunidad.Models.Post extends Backbone.Model
  paramRoot: 'post'
  
  initialize: ->

  toJSON: ->
    r = _.clone @attributes
    r.user = (app.users.get @get 'user_id').toJSON()
    delete r[key] for key in ['user_id', 'votes', 'comments', 'attachement']
    r


class Lacomunidad.Collections.PostsCollection extends Backbone.Collection
  model: Lacomunidad.Models.Post
  url: ->
    window.Routes.posts_path()
    
  parse: (posts) ->
    for p in posts
      p.comments = new Lacomunidad.Collections.CommentsCollection comments: p.comments, post_id: p.id
      p.votes = new Lacomunidad.Collections.VotesCollection votes: p.votes, post_id: p.id
      p.attachement = new Lacomunidad.Models.Attachement p.attachement if p.attachement
    posts

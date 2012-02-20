Lacomunidad.Views.Posts ||= {}

class Lacomunidad.Views.Posts.PostView extends Backbone.View
  template: JST["templates/posts/post"]
  stats_template: JST["templates/posts/stats"]

  tagName: 'li'
  className: 'post fade'

  events:
    'click .stats .comments_count': 'comments_count_click'
    'click .stats .thumbs_up': 'vote_for'
    'click .stats .thumbs_down': 'vote_against'
    'click .destroy_post': 'destroy_click'

  initialize: ->
    @comments = new Lacomunidad.Collections.CommentsCollection comments: @model.get('comments'), post_id: @model.get('id')
    @votes = new Lacomunidad.Collections.VotesCollection votes: @model.get('votes'), post_id: @model.get('id')
    @attach = new Lacomunidad.Models.Attach @model.get 'attach' if @model.get 'attach'
    
    #re-render if user voted or commented
    @votes.bind 'reset', @renderStats
    @comments.bind 'all', @renderStats

  destroy_click: (event) ->
    event.preventDefault()
    @model.destroy()
    $(@el).removeClass('in')
    setTimeout (()=>$(@el).remove()), 500

  vote_for: (event) ->
    @votes.vote 'up'

  vote_against: (event) ->
    @votes.vote 'down'

  comments_count_click: (event) ->
    #caution!. .new_comment_input belongs to a sub-view
    @$('.new_comment_input').focus()

  renderStats: =>
    data =
      created_at: @model.get 'created_at'
      thumbs_up: @votes.votes_for().length
      thumbs_down: @votes.votes_against().length
      comments_count: @comments.length

    @$('.stats').html @stats_template data
    @$('.stats time.when').timeago()    
    @

  render: ->
    $(this.el).html @template post: @model.toJSON(), user: app.users.get(@model.get('user_id')).toJSON()
    @renderStats()
    if @attach
      view = new Lacomunidad.Views.Posts.AttachementView({model: @attach})
      @$(".content .attach").html view.render().el
    view = new Lacomunidad.Views.Comments.ListView({collection: @comments})
    @$(".comments").html view.render().el
    setTimeout (()=>$(@el).addClass('in')), 500
    @
    

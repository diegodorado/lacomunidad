Lacomunidad.Views.Posts ||= {}

class Lacomunidad.Views.Posts.StatsView extends Backbone.View
  template: JST["backbone/templates/posts/stats"]
  className: 'foot stats'

  events:
    'click .comments_count': 'comments_count_click'
    'click .thumbs_up': 'vote_for'
    'click .thumbs_down': 'vote_against'

  initialize: ->
    @votes = (@model.get 'votes')
    #re-render if user voted or commented
    @votes.bind 'reset', => @render()
    (@model.get 'comments').bind 'all', => @render()

  vote_for: (event) ->
    @votes.vote 'up'

  vote_against: (event) ->
    @votes.vote 'down'

  comments_count_click: (event) ->
    (@model.get 'comments').create { comment:'testing coment add'}
    
  render: =>
    data =
      created_at: @model.get 'created_at'
      thumbs_up: @votes.votes_for().length
      thumbs_down: @votes.votes_against().length
      comments_count: (@model.get 'comments').length

    $(this.el).html @template data
    $("time.when").timeago()    
    @

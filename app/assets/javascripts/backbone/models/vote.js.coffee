class Lacomunidad.Models.Vote extends Backbone.Model

class Lacomunidad.Collections.VotesCollection extends Backbone.Collection
  model: Lacomunidad.Models.Vote

  initialize: (options)->
    @post_id = options.post_id
    @reset options.votes
  
  url: ->
    window.Routes.vote_post_path @post_id

  votes_for: ->
    @filter (vote) ->
      vote.get 'vote'

  votes_against: ->
    @without.apply @, @votes_for()

  vote: (direction)->
    $.ajax
      url: @url()
      type: 'POST'
      data: {direction: direction}
      success: @voteCallback
    
  voteCallback: (data)=>
    @reset data.votes

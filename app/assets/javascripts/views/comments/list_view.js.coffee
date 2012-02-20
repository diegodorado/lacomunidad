Lacomunidad.Views.Comments ||= {}

class Lacomunidad.Views.Comments.ListView extends Backbone.View
  template: JST["templates/comments/list"]

  events:
    'keypress .new_comment_input': 'new_comment_keypress'
    'focus .new_comment_input': 'new_comment_focus'
    'blur .new_comment_input': 'new_comment_blur'

  initialize: ->
    @collection.bind 'reset', @addComments
    @collection.bind 'add', @addComment

  addComments: =>
    @collection.each(@addComment)

  addComment: (comment) =>
    view = new Lacomunidad.Views.Comments.CommentView model : comment
    @$("ul.comments").append view.render().el

  new_comment_keypress: (event) ->
    return event.preventDefault() if event.keyCode is 9
    return unless event.keyCode is 13 and not event.shiftKey
    event.preventDefault()
    input = @$('.new_comment_input')
    comment = input.val()
    return unless comment
    @collection.create {comment: comment}
    input.val ''
    input.blur()

  new_comment_focus: (event) ->
    @$('.new_comment').addClass 'typing'
    @$('.new_comment_input').autogrow()
    
  new_comment_blur: (event) ->
    @$('.new_comment').removeClass 'typing' unless @$('.new_comment_input').val()
    
  render: ->
    $(@el).html @template()
    @$(".new_comment_input").tooltip { trigger:'focus',placement: 'right', title: 'presiona enter para comentar'}
    
    @addComments()
    @

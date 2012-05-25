Lacomunidad.Views.Comments ||= {}

class Lacomunidad.Views.Comments.NewCommentView extends Backbone.View
  template: JST["templates/comments/new_comment"]
  className: 'new_comment'

  events:
    'keypress .new_comment_input': 'new_comment_keypress'
    'focus .new_comment_input': 'new_comment_focus'
    'blur .new_comment_input': 'new_comment_blur'

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
    @$(@el).addClass 'typing'
    @$(@el).autogrow()
    
  new_comment_blur: (event) ->
    @$(@el).removeClass 'typing' unless @$('.new_comment_input').val()

  render: ->
    $(@el).html @template()
    @

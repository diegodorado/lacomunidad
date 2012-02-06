Lacomunidad.Views.Comments ||= {}

class Lacomunidad.Views.Comments.ListView extends Backbone.View
  template: JST["backbone/templates/comments/list"]

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
    @collection.create {comment: input.val()}
    input.val ''
    input.blur()

  new_comment_focus: (event) ->
    @$('.new_comment').addClass 'typing'
    @$('.new_comment_input').autogrow()
    
  new_comment_blur: (event) ->
    @$('.new_comment').removeClass 'typing' unless @$('.new_comment_input').val()
    
  showHint: (event) ->
    tooltip = @$('.ui-tooltip-top')
    input = @$('#new-todo')
    tooltip.fadeOut()
    clearTimeout @tooltipTimeout if @tooltipTimeout
    return if input.val() is '' or  input.val() is input.attr 'placeholder'
    @tooltipTimeout = setTimeout (-> tooltip.fadeIn()), 1000    


  render: ->
    $(@el).html @template()
    @addComments()
    @

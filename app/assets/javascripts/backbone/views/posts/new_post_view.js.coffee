Lacomunidad.Views.Posts ||= {}

class Lacomunidad.Views.Posts.NewPostView extends Backbone.View
  template: JST["backbone/templates/posts/new_post"]

  events:
    'focus .new_post_input': 'new_post_focus'
    'blur .new_post_input': 'new_post_blur'
    'click .new_post_submit': 'new_post_submit'
    

  new_post_focus: (event) ->
    @$('#publicar').addClass 'typing'
    @$('.new_post_input').autogrow()
    
  new_post_blur: (event) ->
    @$('#publicar').removeClass 'typing' unless @$('.new_post_input').val()

  new_post_submit: (event) ->
    console.log event

  render: ->
    $(this.el).html(@template())
    @

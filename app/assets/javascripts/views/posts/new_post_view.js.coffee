Lacomunidad.Views.Posts ||= {}

class Lacomunidad.Views.Posts.NewPostView extends Backbone.View
  template: JST["templates/posts/new_post"]
  el: '#new_post'
  
  initialize: ->
    @model = new Lacomunidad.Models.Post {user_id : app.user_id}
    @attach = new Lacomunidad.Models.Attach
    @attach.bind 'fetched', @attach_fetched
      
  events:
    'focus .new_post_input': 'new_post_focus'
    'blur .new_post_input': 'new_post_blur'
    'keypress .new_post_input': 'new_post_keypress'
    'click .destroy_attach': 'destroy_attach_click'

  attach_fetched: (attach)=>
    @$("#post_og .image").empty().removeClass 'loaded'
    for field in ['title','description','url']
      @$("#post_og .#{field}").html attach.get field
    @model.set {attach: attach.toJSON()}
    img = $(new Image()).css('display', 'none').attr('width', '120').attr('src', attach.get('image'))
    img.load =>
      @$("#post_og .image").addClass('loaded').html img
      $(img).fadeIn()
      @$(".new_post_input").tooltip('show')
    @$(".new_post_input").tooltip('hide')
    @$("#post_og").fadeIn()

  new_post_focus: (event) ->
    $(@el).addClass 'typing'
    @$('.new_post_input').autogrow()
    
  new_post_blur: (event) ->
    $(@el).removeClass 'typing' unless @$('.new_post_input').val()

  #use fat arrow since its a custom bind, not a backbone one
  new_post_edit: (event) =>
    @attach.parse @$('.new_post_input').val()
  
  new_post_keypress: (event) ->
    return event.preventDefault() if event.keyCode is 9 #prevent tab
    return unless event.keyCode is 13 and not event.shiftKey
    event.preventDefault()
    input = @$('.new_post_input')
    return unless input.val()
    @model.set {body: input.val()}

    @collection.create @model.toJSON(), {silent:true, success: ((model)=> @collection.trigger 'posted', model)}
    #@collection.trigger 'posted', created
    input.val ''
    input.blur()
    @destroy_attach()
  

  destroy_attach: ->
    @attach.clear()
    @model.set {attach: null}
    @$("#post_og").fadeOut()

  destroy_attach_click: (event) ->
    event.preventDefault()
    @destroy_attach()

  #must return a value for editInPlace
  editInPlaceCallback: (field, html, ori) ->
    if html
      data = {}
      data[field] = html
      @attach.set data
      @model.set {attach: @attach.toJSON()}
      return html    
    else
      return ori

  render: ->
    $(@el).html(@template())
    @$(".new_post_input").tooltip { trigger:'focus',placement: 'right', title: 'presiona enter para compartir'}
    @$('.new_post_input').bind 'edit', @new_post_edit
    @$("#post_og .title").editInPlace
        callback: (oe, html, ori) => @editInPlaceCallback('title', html, ori)
    @$("#post_og .description").editInPlace
        field_type:'textarea',
        callback: (oe, html, ori) => @editInPlaceCallback('description', html, ori)
    @

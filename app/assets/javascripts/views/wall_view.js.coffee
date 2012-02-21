class Lacomunidad.Views.WallView extends Backbone.View
  template: JST["templates/wall"]
  el: '#wall_viewport'

  initialize: ->
    @collection.bind 'reset', @addPosts
    #newly created post must be prepended, not appended
    @collection.bind 'add', @prependPost

  addPosts: =>
    @collection.each(@addPost)
    @bind_scroll_handler()  

  prependPost: (post) =>
    view = new Lacomunidad.Views.Posts.PostView {model : post}
    @$("#posts .posts_list").prepend view.render().el

  addPost: (post) =>
    view = new Lacomunidad.Views.Posts.PostView {model : post}
    @$("#posts .posts_list").append view.render().el

  render: ->
    $(this.el).html(@template())
    view = new Lacomunidad.Views.Posts.NewPostView {collection: @collection}
    view.render()
    @

  near_bottom: ->
    ($(window).height() + $(window).scrollTop()) > @$('.posts_list li.post:last').offset().top

  bind_scroll_handler:  ->
    console.log 'window scroll bound'
    $(window).bind 'scroll', @scroll_handler
  unbind_scroll_handler:  ->
    console.log 'window scroll unbound'
    $(window).unbind 'scroll', @scroll_handler
    
  scroll_handler: (event) =>
    if @near_bottom()
      console.log 'bottom reached'
      @unbind_scroll_handler()
      ts = @collection.min (post) ->
        Date.parse(post.get('created_at'))
      .get('created_at')
      @collection.fetch {data: {ts: ts}}
      


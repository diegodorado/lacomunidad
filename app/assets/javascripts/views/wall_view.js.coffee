class Lacomunidad.Views.WallView extends Backbone.View
  template: JST["templates/wall"]
  el: '#wall_viewport'

  initialize: ->
    @collection.bind 'reset', @addPosts
    #newly created post must be prepended, not appended
    @collection.bind 'add', @prependPost

  addPosts: =>
    @collection.each(@addPost)

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
    $(window).bind 'scroll', @scroll_handler
    @
    
  scroll_handler: (event) =>
    #console.log $(document).height(),$(window).height(), $(window).scrollTop()
    console.log $(document).height(),$(window).height() + $(window).scrollTop(), @$('.posts_list li.post:last').offset().top
    #treshold = el.offset().top + el.height();


	stop_scroll: ->
    $(window).unbind 'scroll', @scroll_handler


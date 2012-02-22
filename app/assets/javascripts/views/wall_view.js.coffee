class Lacomunidad.Views.WallView extends Backbone.View
  template: JST["templates/wall"]
  el: '#wall_viewport'

  initialize: ->
    @collection.bind 'reset', @addPosts
    @collection.bind 'add', @addPost
    @collection.bind 'posted', @prependPost

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
    @bind_scroll_handler()
    @

  near_bottom: ->
    ($(window).height() + $(window).scrollTop()) > @$('.posts_list li.post:last').offset().top

  bind_scroll_handler:  ->
    $(window).bind 'scroll', @scroll_handler
    
  unbind_scroll_handler:  ->
    $(window).unbind 'scroll', @scroll_handler
    

  scroll_handler: (event) =>
    if @near_bottom()
      @unbind_scroll_handler()
      ts = @collection.min (post) ->
        Date.parse(post.get('created_at'))
      .get('created_at')
      @collection.fetch {data: {ts: ts}, add:true, success: @fetchCallback}

  fetchCallback: (collection, models) =>
    #bind only if there may be more posts
    @bind_scroll_handler() if models.length < 10  
    
    
    

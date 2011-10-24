Lacomunidad.Views.Posts ||= {}

class Lacomunidad.Views.Posts.ListView extends Backbone.View
  template: JST["backbone/templates/posts/list"]

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')

    @options.posts.bind('reset', @addAll)

  addAll: () ->
    @options.posts.each(@addOne)

  addOne: (post) ->
    view = new Lacomunidad.Views.Posts.PostView({model : post})
    @$(".posts_list").append(view.render().el)

  render: ->
    $(@el).html(@template(posts: @options.posts.toJSON() ))
    @addAll()
    return this    

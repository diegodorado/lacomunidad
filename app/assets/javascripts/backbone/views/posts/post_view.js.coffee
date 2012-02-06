Lacomunidad.Views.Posts ||= {}

class Lacomunidad.Views.Posts.PostView extends Backbone.View
  template: JST["backbone/templates/posts/post"]

  tagName: 'li'
  className: 'post'

  render: ->
    $(this.el).html @template @model.toJSON()
    if @model.get 'attachement'
      view = new Lacomunidad.Views.Posts.AttachementView({model: @model.get 'attachement'})
      @$(".content").append view.render().el
    view = new Lacomunidad.Views.Posts.StatsView({model: @model})
    @$(".content").append view.render().el
    
    view = new Lacomunidad.Views.Comments.ListView({collection: @model.get 'comments'})
    @$(".content").append view.render().el
    
    @

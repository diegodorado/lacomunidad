Lacomunidad.Views.Comments ||= {}

class Lacomunidad.Views.Comments.ListView extends Backbone.View
  template: JST["templates/comments/list"]

  initialize: ->
    @collection.bind 'reset', @addComments
    @collection.bind 'add', @addComment

  addComments: =>
    @collection.each(@addComment)

  addComment: (comment) =>
    view = new Lacomunidad.Views.Comments.CommentView model : comment
    @$("ul.comments").append view.render().el

    
  render: ->
    $(@el).html @template()
    @$(".new_comment_input").tooltip { trigger:'focus',placement: 'right', title: 'presiona enter para comentar'}
    @addComments()
    if app.user_id
      view = new Lacomunidad.Views.Comments.NewCommentView {collection: @collection}
      @$(@el).append view.render().el
    @

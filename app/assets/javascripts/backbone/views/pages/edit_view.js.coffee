Lacomunidad.Views.Pages ||= {}

class Lacomunidad.Views.Pages.EditView extends Backbone.View
  template : JST["backbone/templates/pages/edit"]
  
  events :
    "submit #edit-page" : "update"
    
  update : (e) ->
    e.preventDefault()
    e.stopPropagation()
    
    @model.save(null,
      success : (page) =>
        @model = page
        window.location.hash = "/#{@model.id}"
    )
    
  render : ->
    $(this.el).html(this.template(@model.toJSON() ))
    
    this.$("form").backboneLink(@model)
    
    return this
Lacomunidad.Views.Pages ||= {}

class Lacomunidad.Views.Pages.NewView extends Backbone.View    
  template: JST["backbone/templates/pages/new"]
  
  events:
    "submit #new-page": "save"
    
  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )
    
  save: (e) ->
    e.preventDefault()
    e.stopPropagation()
      
    @model.unset("errors")
    
    @collection.create(@model.toJSON(), 
      success: (page) =>
        @model = page
        window.location.hash = "/#{@model.id}"
        
      error: (page, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )
    
  render: ->
    $(this.el).html(@template(@model.toJSON() ))
    
    this.$("form").backboneLink(@model)
    
    return this
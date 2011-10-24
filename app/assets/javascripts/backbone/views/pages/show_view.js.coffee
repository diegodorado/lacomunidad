Lacomunidad.Views.Pages ||= {}

class Lacomunidad.Views.Pages.ShowView extends Backbone.View
  template: JST["backbone/templates/pages/show"]
   
  render: ->
    $(this.el).html(@template(@model.toJSON() ))
    return this
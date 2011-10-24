class Lacomunidad.Models.Page extends Backbone.Model
  paramRoot: 'page'

  defaults:
    title: null
    content: null
  
class Lacomunidad.Collections.PagesCollection extends Backbone.Collection
  model: Lacomunidad.Models.Page
  url: '/pages'
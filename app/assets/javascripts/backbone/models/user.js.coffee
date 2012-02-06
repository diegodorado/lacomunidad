class Lacomunidad.Models.Users extends Backbone.Model
 initialize: ->

class Lacomunidad.Collections.UsersCollection extends Backbone.Collection
  model: Lacomunidad.Models.Users
  url: ->
    window.Routes.users_path()

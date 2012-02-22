class Lacomunidad.Models.Attach extends Backbone.Model
  xhr: null
  cached_url: null
  parsed_url: null
  url_parser: /\b(https?:\/\/)?(([a-z0-9][-\w]{2,}[a-z0-9]\.)+[a-z]{2,})([-\w\.\?\\/@&#;`~=%!]*)?\b/
  
  parse: (text) ->
    m  = @url_parser.exec(text)
    return unless m
    return if @parsed_url is m[0]
    @parsed_url = m[0]
    @process_parsed_url()
    #todo: do not process inmediately... maybe user is typing
    #clearTimeout @timer if @timer
    #@timer = setTimeout @process_parsed_url , 1500
    
  process_parsed_url: =>
    return if @parsed_url is @cached_url
    return if @xhr
    @cached_url = @parsed_url
    @fetch()
  
  fetch: ->
    @clear()
    @xhr = $.ajax
      url: Routes.opengraph_path()
      timeout: 5000
      type: 'POST'
      data: {url: @cached_url}
      success: @successCallback
      error:  @errorCallback

  successCallback: (data)=>
    @xhr = null
    #check if url was changed while fetching
    if @parsed_url isnt @cached_url
      #fetch again
      @fetch @parsed_url
    else
      return if data.error
      @set data
      @trigger 'fetched', @

  errorCallback: (jqXHR, textStatus, errorThrown)=>
    @xhr = null
    @clear()
    


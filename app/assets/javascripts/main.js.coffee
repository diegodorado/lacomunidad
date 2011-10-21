$ ->
  $(document).ajaxStart -> $('#ajax-indicator').show()
  $(document).ajaxStop ->  $('#ajax-indicator').hide()
  App.init $('body').attr('class')

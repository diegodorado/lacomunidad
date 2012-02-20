@Utils = {}

Utils.modal =
  initialized: false
  init: ->
    if @initialized then return false
    @container = $('<div style="display:none;"/>')
    @content = $("<div style='overflow:auto;padding: 20px;position: fixed;left: 0;top: 0;background: #fff;border: 1px solid #222;z-index:2000'/>")
    #modal.css "top", ($(document).height() - params.height - 50) / 2
    #modal.css "left", (screen.width - params.width - 20) / 2
    overlay = $("<div style='position: fixed;top: 0;left: 0;width: 100%;height: 100%;background: #222;' />")
    overlay.css "opacity", 0.7
    overlay.click =>
      @hide()
    @container.append overlay
    @container.append @content
    $('body').append @container
    @initialized= true

  show: (html) ->
    @init()
    console.log this
    @content.html html
    @container.show()

  hide: ->
    @container.hide()

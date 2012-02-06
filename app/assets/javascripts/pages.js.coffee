App.Pages =
  init: ->
    if @is_edit_page() then @initEditor()

  edit_form_selector: 'form.edit_page'

  is_edit_page: ->
    $(@edit_form_selector).size() == 1

  initEditor: ->
    @initMarkdownEditor()
    @initThumbChooser()
    $.getScript "//google.com/jsapi?callback=App.Pages.jsapiLoaded"

  jsapiLoaded: ->
    google.load "picker", "1", {'language':'es',"callback" : @pickerLoaded}

  pickerCalled: false

  pickerLoaded: ->
    App.Pages.buildPicker()

  buildPicker: ->
    pb = new google.picker.PickerBuilder()
    pb.addView google.picker.ViewId.IMAGE_SEARCH
    pb.addView google.picker.ViewId.PHOTO_UPLOAD
    pb.addView google.picker.ViewId.PHOTOS
    pb.addView google.picker.ViewId.VIDEO_SEARCH
    pb.setCallback @pickerSelected
    @picker = pb.build()
    #if picker was called before it was built, then show it
    if @pickerCalled then @showPicker()

  showPicker: ->
    @picker.setVisible true

  callPicker: ->
    if @picker
      @showPicker()
    else
      #picker was called, but not built
      #remember that to show picker once built
      @pickerCalled= true

  initMarkdownEditor: ->
    $('textarea').markdownEditor()
    $(".editor .function-image").bind "click", =>
      @callPicker()

  initThumbChooser: ->
    @thumbChooser = $('#thumb_chooser')
    @thumbChooser.find('.media-grid a').live 'click', (event) => @thumbSelected event

  pickerSelected: (data) ->
    if data.action is google.picker.Action.PICKED
      doc = data.docs[0]
      switch doc.type
        when 'photo' then App.Pages.selectThumb doc
        when 'video'
          txt = "<iframe width=\"420\" height=\"315\" src=\"#{doc.embedUrl}\" frameborder=\"0\" allowfullscreen></iframe>\n"
          $.markdownEditor.executeAction $(".editor"), /(.+)([\n]?)/, txt, true

  selectThumb: (doc) ->
    mg = @thumbChooser.find('.media-grid')
    mg.empty()
    for index, thumb of doc.thumbnails
      mg.append("<li><a href=\"#{thumb.url}\" title=\"#{doc.name}\">#{thumb.width}&times;#{thumb.height}</a></li>")
    @thumbChooser.modal 'show'

  thumbSelected: (event) ->
    event.preventDefault()
    @thumbChooser.modal 'hide'
    title =  event.target.title
    url = event.target.href
    txt = "![#{title}](#{url} \"#{title}\")  \n"
    $.markdownEditor.executeAction $(".editor"), /(.+)([\n]?)/, txt, true

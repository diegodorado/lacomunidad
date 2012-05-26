###
Lightbox v2.51
by Lokesh Dhakar - http://www.lokeshdhakar.com

For more information, visit:
http://lokeshdhakar.com/projects/lightbox2/

Licensed under the Creative Commons Attribution 2.5 License - http://creativecommons.org/licenses/by/2.5/
- free for use in both personal and commercial projects
- attribution requires leaving author name, author link, and the license info intact
	
Thanks
- Scott Upton(uptonic.com), Peter-Paul Koch(quirksmode.com), and Thomas Fuchs(mir.aculo.us) for ideas, libs, and snippets.
- Artemy Tregubenko (arty.name) for cleanup and help in updating to latest proto-aculous in v2.05.


Table of Contents
=================
LightboxOptions

Lightbox
- constructor
- init
- enable
- build
- start
- changeImage
- sizeContainer
- showImage
- updateNav
- updateDetails
- preloadNeigbhoringImages
- enableKeyboardNav
- disableKeyboardNav
- keyboardAction
- end

options = new LightboxOptions
lightbox = new Lightbox options

###

# Use local alias
$ = jQuery

class LightboxOptions
  constructor: ->
    @resizeDuration = 700
    @fadeDuration = 500

class Lightbox
  constructor: (@options) ->
    @album = []
    @currentImageIndex = undefined
    @init()
    
  
  init: ->
    @enable()
    @build()


  # Loop through anchors and areamaps looking for rel attributes that contain 'lightbox'
  # On clicking these, start lightbox.
  enable: ->
    $('body').on 'click', 'a[rel^=lightbox], area[rel^=lightbox]', (e) =>
      e.preventDefault()
      console.log $(e.currentTarget)
      @start $(e.currentTarget)


  # Build html for the lightbox and the overlay.
  # Attach event handlers to the DOM elements. click click click
  build: ->
    $('#lightbox').on 'click', (e) =>
      e.preventDefault()
      switch $(e.target).attr('class')
        when "lb-prev" then @changeImage @currentImageIndex - 1
        when "lb-next" then @changeImage @currentImageIndex + 1
        else @end()
    return

  # Show overlay and lightbox. If the image is part of a set, add siblings to album array.
  start: ($link) ->
    $('select, object, embed').css visibility: "hidden"

    @album = []
    imageNumber = 0

    if $link.attr('rel') == 'lightbox'
      # If image is not part of a set
      @album.push link: $link.attr('href'), title: $link.attr('title')
    else
      # Image is part of a set
      for a, i in $( $link.prop("tagName") + '[rel="' + $link.attr('rel') + '"]')
        @album.push link: $(a).attr('href'), title: $(a).attr('title')
        if $(a).attr('href') == $link.attr('href')
          imageNumber = i

    $lightbox = $('#lightbox').fadeIn( @options.fadeDuration)
    $lightbox.find('.lb-container').height($(window).height() - 80)
    
    @changeImage(imageNumber)
    return
  

  # Hide most UI elements in preparation for the animated resizing of the lightbox.
  changeImage: (imageNumber) ->
    
    @disableKeyboardNav()    
    $lightbox = $('#lightbox')
    $image = $lightbox.find('.lb-image')

    $('.loader').fadeIn 'slow'
    $lightbox.find('.lb-image, .lb-prev, .lb-next').hide()

    # When image to show is preloaded, we send the width and height to sizeContainer()
    preloader = new Image
    preloader.onload = () =>
      $image.attr 'src', @album[imageNumber].link
      # Bug fix by Andy Scott 
      $image.width = preloader.width
      $image.height = preloader.height
      # End of bug fix
      @sizeContainer preloader.width, preloader.height

    preloader.src = @album[imageNumber].link
    @currentImageIndex = imageNumber
    return  


  
  
  # Animate the size of the lightbox to fit the image we are showing
  sizeContainer: (imageWidth, imageHeight) ->

    $lightbox = $('#lightbox')
    containerHeight = $lightbox.find('.lb-container').height()
    containerWidth = $lightbox.find('.lb-container .lb-center').width()
    wider = imageWidth>containerWidth
    higher = imageHeight>containerHeight
    
    computedHeight = imageHeight * containerWidth / imageWidth
    computedWidth = imageWidth * containerHeight / imageHeight    
    computedHeight2 = imageHeight * computedWidth / imageWidth
    imageHeight = Math.min(imageHeight,computedHeight,computedHeight2)
    
    $lightbox.find('.lb-image').css('margin-top', "#{(containerHeight-imageHeight)/2}px")

    # Wait for resize animation to finsh before showing the image
    setTimeout =>
      @showImage()
      return
    , @options.resizeDuration 
    
    return

  
  # Display the image and it's details and begin preload neighboring images.
  showImage: ->
    $lightbox = $('#lightbox')
    $lightbox.find('.lb-loader').hide()
    $lightbox.find('.lb-image').fadeIn 'slow'

    @updateNav()
    @preloadNeighboringImages()
    @enableKeyboardNav()

    return


  # Display previous and next navigation if appropriate.
  updateNav: ->
    $lightbox = $('#lightbox')
    if @currentImageIndex > 0 then $lightbox.find('.lb-prev').show();
    if @currentImageIndex < @album.length - 1 then $lightbox.find('.lb-next').show();
    return
  
    
    
  # Preload previos and next images in set.  
  preloadNeighboringImages: ->
   if @album.length > @currentImageIndex + 1
      preloadNext = new Image
      preloadNext.src = @album[@currentImageIndex + 1].link

    if @currentImageIndex > 0
      preloadPrev = new Image
      preloadPrev.src = @album[@currentImageIndex - 1].link    
    return


  enableKeyboardNav: ->
    $(document).on 'keyup.keyboard', $.proxy( @keyboardAction, this)
    return

  
  disableKeyboardNav: ->
    $(document).off '.keyboard'
    return
  
    
  keyboardAction: (event) ->
    KEYCODE_ESC = 27
    KEYCODE_LEFTARROW = 37
    KEYCODE_RIGHTARROW = 39

    keycode = event.keyCode
    key = String.fromCharCode(keycode).toLowerCase()

    if keycode == KEYCODE_ESC || key.match(/x|o|c/)
      @end()
    else if key == 'p' || keycode == KEYCODE_LEFTARROW
      if @currentImageIndex != 0
          @changeImage @currentImageIndex - 1
    else if key == 'n' || keycode == KEYCODE_RIGHTARROW
      if @currentImageIndex != @album.length - 1
          @changeImage @currentImageIndex + 1
    return

  
  # Closing time. :-(
  end: ->
    @disableKeyboardNav()
    $('#lightbox').fadeOut @options.fadeDuration
    $('select, object, embed').css visibility: "visible"
        
    
$ ->
  options = new LightboxOptions
  lightbox = new Lightbox options

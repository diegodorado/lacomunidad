@App =
  init: (body_class) ->
    switch body_class
      when "wall" then Wall.init()
  
Wall =
  init: ->
    @bind_comments_count_click()
    @bind_comment_forms_textarea_focus()
    @bind_comment_forms_textarea_blur()
    @bind_post_body_focus()
    @bind_post_body_blur()
    @bind_post_body_edit()
    @bind_post_og_hide_click()
    @bind_post_og_edit_in_place()

  bind_comments_count_click: ->
    $('#posts_list .content .foot a.comments_count').live 'click', (e) ->
      target = $(e.target)
      target.parent().nextAll('.comment_form').find('textarea').focus()
      return false

  bind_comment_forms_textarea_focus: ->
    $('#posts_list .content .comment_form textarea').live 'focus', (e) ->
      target = $(e.target)
      if !target.data('original.text')
        target.elastic()
        target.data('original.text',target.val())
      if target.data('original.text')==target.val()
        target.val('')
        target.parent().prev('.avatar').show()
        target.parent().next('.submit').show()

  bind_comment_forms_textarea_blur: ->
    $('#posts_list .content .comment_form textarea').live 'blur', (e) ->
      target = $(e.target)
      if !target.val()
        target.val(target.data('original.text'))
        target.parent().prev('.avatar').hide()
        target.parent().next('.submit').hide()

  bind_post_body_focus: ->
    $('#post_body').bind 'focus', (e) ->
      target = $(e.target)
      if  !target.data('original.text')
        target.elastic()
        target.data('original.text',target.val())
      if target.data('original.text') is target.val()
        target.val('')
        $('#publicar_submit').show()

  bind_post_body_blur: ->
    $('#post_body').bind 'blur', (e) ->
      target = $(e.target)
      if !target.val()
        target.val(target.data('original.text'))
        $('#publicar_submit').hide()

  bind_post_body_edit: ->
    $('#post_body').bind 'edit', (e) ->
      target = $(e.target)
      url = parseUri(target.val())
      if url? and (url isnt target.data('url'))
        target.data('url', url)
        $.ajax({ url: Routes.create_post_og_path(), type: 'POST', data: {url: url} });


  bind_post_og_hide_click: ->
    $("#post_og a.hide").click (e) ->
      $('input[id^="post_attachement_attributes"]').val('')
      $("#post_og").fadeOut()
      return false

  bind_post_og_edit_in_place: ->

    $("#post_og .content .title").editInPlace
        callback: (oe, html, ori) ->
          html = html ? html : ori
          $('#post_attachement_attributes_title').val(html)
          return html
    
    $("#post_og .content .description").editInPlace
        field_type:'textarea',
        callback: (oe, html, ori) ->
          html = html ? html : ori
          $('#post_attachement_attributes_description').val(html)
          return html


###    

class Dog
  constructor: (@body_classes) ->
  speak: (line) ->
    alert "The #{@adjective} rabbit says '#{line}'"


###

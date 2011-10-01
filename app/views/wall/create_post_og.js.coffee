$('#post_attachement_attributes_title').val("<%=@og.title.html_safe %>")
$('#post_attachement_attributes_url').val("<%=@og.url %>")
$('#post_attachement_attributes_description').val("<%=@og.description.html_safe %>");
$('#post_attachement_attributes_image').val("<%=@og.image %>")
$('#post_attachement_attributes_video').val("<%=@og.video %>")

$('#post_og .title').html("<%=@og.title.html_safe %>")
$('#post_og .url').html("<%=@og.url %>")
$('#post_og .description').html("<%=@og.description.html_safe %>")

$('#post_og .image_wrapper .image').hide()
$('#post_og .image_wrapper .waiting').show()
$('#post_og .image_wrapper .image').empty()
$(new Image()).attr('width', '120').attr('src', '<%=@og.image %>').load ->
  $('#post_og .image_wrapper .image').html(this)
  $('#post_og .image_wrapper .waiting').hide()
  $('#post_og .image_wrapper .image').show()

$("#post_og").fadeIn()

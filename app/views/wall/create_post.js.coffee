$('#posts_list').prepend("<%= escape_javascript(render :partial => "post", :locals => { :post => @post }) %>")
$('#post_body').val("")
$('input[id^="post_attachement_attributes"]').val('')
$("#post_og").fadeOut()
$('#posts_list > li.more').remove()
$('#posts_list').append("<%= escape_javascript(render :partial => "posts_list", :locals => { :posts => @posts, :@offset => @view_more_offset }) %>")
$('#post_<%= @post.id %> .comments').prepend("<%= escape_javascript(render :partial => "comment", :locals => { :comment => @comment }) %>")
#$('#post_<%= @post.id %> .comments li.comment:last').remove()
$('#post_<%= @post.id %> .comments .comments_count').text(<%= @post.comments.count %>)
$('#comment_comment_for_<%= @post.id %>').val("")
$('#comment_comment_for_<%= @post.id %>').trigger('blur')
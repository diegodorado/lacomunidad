$('#post_<%= @post.id %> .content .comments li.more').remove()
<%
  val = '' 
  @comments.each do |c| 
    val  << escape_javascript(render :partial => "comment", :locals => { :comment => c })
  end
%>    
$('#post_<%= @post.id %> .content .comments').append("<%= val.html_safe %>") #already escaped
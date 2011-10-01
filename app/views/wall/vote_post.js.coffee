$('#post_<%= @post.id %> .content .foot .thumbs_up').text("<%= @post.votes_for%>");
$('#post_<%= @post.id %> .content .foot .thumbs_down').text("<%= @post.votes_against%>");

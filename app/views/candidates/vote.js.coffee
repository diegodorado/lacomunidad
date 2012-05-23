$('#candidate_<%=@candidate.id%> .vote-status').html "<%=escape_javascript(render( 'vote_status', :candidate => @candidate)).html_safe%>"
#$('#candidate_<%=@candidate.id%> .vote-status').html('<%=@value%>').effect("highlight", {}, 3000)


window.parseUri= (str) ->
  parser = /\b(https?:\/\/)?(([a-z0-9][-\w]{2,}[a-z0-9]\.)+[a-z]{2,})([-\w\.\?\\/@&#;`~=%!]*)?\b/
  m  = parser.exec(str)
  if m then m[0] else false
  

@App =
  init: (body_class) ->
    switch body_class
      #when "wall" then @Wall.init()
      when "pages" then @Pages.init()

module ApplicationHelper 
  def body_classes
    [controller.controller_name]
  end
  def markdown(text)  
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
      :autolink => true)
    markdown.render(text).html_safe
  end  
end

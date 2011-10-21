module ApplicationHelper 
  def body_classes
    [controller.controller_name]
  end
  def markdown(text)  
    Redcarpet.new(text).to_html.html_safe  
  end  
end

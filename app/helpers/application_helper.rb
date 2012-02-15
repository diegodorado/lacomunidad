module ApplicationHelper 

  def body_classes
    [controller.controller_name]
  end

  def markdown(text)  
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
      :autolink => true)
    markdown.render(text).html_safe
  end  

  def user_id
    current_user.id if current_user
  end

  def user_list
    User.user_list.to_json
  end
  
end

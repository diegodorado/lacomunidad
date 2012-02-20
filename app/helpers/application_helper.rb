module ApplicationHelper 

  def body_classes
    [controller.controller_name, controller.action_name]
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
    User.user_list
  end

  def app_js_load(options)
    content_for :app_js_load , "app.load(#{options.to_json});\n".html_safe
  end
  
end

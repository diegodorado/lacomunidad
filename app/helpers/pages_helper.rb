module PagesHelper

  def wikify(content)
    sanitize(auto_link(textilize linkify(content)))
  end

  def linkify( str )
    str.gsub /\[\[([^\[\]]+)\]\]?/xu do
      link_to_page $1
    end.html_safe
  end

  def link_to_page(title)
    link_to title, show_page_path(slugify(title))
  end  

  def slugify( str )
    str.gsub(/\s/, "_")
  end  

  def unslugify( str )
    str.gsub(/_/, " ")
  end  

end

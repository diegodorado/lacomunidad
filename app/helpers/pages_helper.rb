module PagesHelper

  def wikify(content)
    #sanitize(auto_link(textilize linkify(content)))
    sanitize(textilize linkify(content))
  end

  def linkify( str )
    str.gsub /\[\[([^\[\]]+)\]\]?/xu do
      p = Page.find_by_title($1)
      link_to p.title, p
    end.html_safe
  end

  def link_to_page(title)
    link_to title, pages_path(slugify(title))
  end  

  def slugify( str )
    str.gsub(/\s/, "_")
  end  

  def unslugify( str )
    str.gsub(/_/, " ")
  end  

end

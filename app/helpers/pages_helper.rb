module PagesHelper

  def wikify(content)
    #markdown auto_link(linkify(content))
    if has_perms?
      markdown linkify_with_perms(content)
    else
      markdown linkify(content)
    end
  end

  def linkify( str )
    str.gsub /\[\[([^\[\]]+)\]\]?/xu do
      title = $1
      link_to title, :id => title.parameterize
    end.html_safe
  end

  def linkify_with_perms( str )
    str.gsub /\[\[([^\[\]]+)\]\]?/xu do
      title = $1
      p = Page.find_by_title title
      if p
        link_to title, p
      else
        link_to title, new_page_path(:title=>title), :method=> :post, :class=> 'not-created', :title=>'Crear Pagina'
      end
    end.html_safe
  end

end

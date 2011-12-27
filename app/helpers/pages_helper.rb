module PagesHelper

  def wikify(content)
    markdown linkify content unless content.nil?
  end

  def linkify( str )
    str.gsub! /\[\[([^\|\[\]]+)\]\]?/xu do
      get_page_link $1, $1
    end
    str.gsub! /\[\[([^\[\|\]]+)\|([^\[\]]+)\]\]?/ do
      get_page_link $2, $1
    end
    str
  end

  def get_page_link(title,page_title)
    page_title.strip!
    if has_perms?
      p = Page.find_by_title page_title
      if p
        link_to title, p
      else
        link_to title, new_page_path(:title=>page_title), :method=> :post, :class=> 'not-created'
      end
    else
      link_to title, :id => page_title.parameterize
    end
  end


end

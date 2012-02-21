module Haml::Filters::Markdown
  include Haml::Filters::Base
  lazy_require "redcarpet"

  def render(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
        :autolink => true, :space_after_headers => true)
    markdown.render(text)  
  end
end

module Haml::Filters::MarkdownWiki
  include Haml::Filters::Base
  lazy_require "redcarpet"

  def render(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
        :autolink => true, :space_after_headers => true)
    markdown.render linkify text
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
    "<a href=\"/pages/#{page_title.parameterize}\">#{title}</a>"
  end  
  
end

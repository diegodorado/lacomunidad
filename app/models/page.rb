class Page < ActiveRecord::Base

  #has_friendly_id :title, :use_slug => true, :approximate_ascii => true, :max_length => 50

  def self.find_by_path_or_new(path)
    #self.find_by_title( title ) || self.new(:title => CGI::unescape(title) )
    title = path.gsub(/_/, " ")
    self.find_by_title( title ) || self.new(:title => title )
  end

  def path
    title.gsub(/\s/, "_")
  end

end

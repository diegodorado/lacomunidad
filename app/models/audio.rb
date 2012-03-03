class Audio < ActiveRecord::Base
  attr_accessible :title, :description,:mp3, :ogg
  has_attached_file :mp3, {
      :storage => :s3, 
      :s3_credentials => "#{Rails.root}/config/s3.yml",
      :path => "/audio_mp3/:id/:filename" 
    }
  has_attached_file :ogg, {
      :storage => :s3, 
      :s3_credentials => "#{Rails.root}/config/s3.yml",
      :path => "/audio_ogg/:id/:filename" 
    }
    

  def file
    mp3.url
  end

  def as_json(options)
    options ||= {}
    defaults = {
      :methods => :file,
      :only=>[:title, :description]
    }
    options = defaults.merge(options)
    super(options)
  end
    
end

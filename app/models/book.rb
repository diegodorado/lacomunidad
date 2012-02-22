class Book < ActiveRecord::Base
  attr_accessible :title, :description, :document, :image
  has_attached_file :document, {
      :storage => :s3, 
      :s3_credentials => "#{Rails.root}/config/s3.yml",
      :path => "/book_document/:id/:filename" 
    }
  has_attached_file :image, {
      :styles => { :thumb => "100x150#", :medium => "200x300#" },
      :storage => :s3, 
      :s3_credentials => "#{Rails.root}/config/s3.yml",
      :path => "/book_image/:style/:id/:filename" 
    }
    
  def thumb
    image.url(:thumb) unless image.nil?
  end

end

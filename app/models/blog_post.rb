class BlogPost < ActiveRecord::Base
  
  acts_as_commentable
  belongs_to :user
  validates :title, :presence => true
  validates :body, :presence => true
  validates :user, :presence => true

  has_attached_file :image, {
      :styles => { :thumb => "100x150#", :medium => "200x300#", :large => "620x280#" },
      :storage => :s3, 
      :s3_credentials => "#{Rails.root}/config/s3.yml",
      :path => "/blog_post_image/:style/:id/:filename" 
    }

end

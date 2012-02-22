class Video < ActiveRecord::Base
  attr_accessible :title, :thumb_url, :embed, :description
  validates :title, :presence => true  
  validates :thumb_url, :presence => true  
  validates :embed, :presence => true  
  validates :description, :presence => true  
end

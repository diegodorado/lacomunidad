class Attachement < ActiveRecord::Base
  belongs_to :post
  validates :url, :presence => true  
  validates :title, :presence => true  
  validates :description, :presence => true  
  
end

class Attachement < ActiveRecord::Base
  belongs_to :post
  validates :url, :presence => true  
  validates :title, :presence => true  
  validates :description, :presence => true  
  
end


# == Schema Information
#
# Table name: attachements
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  url         :string(255)
#  description :string(255)
#  image       :string(255)
#  video       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  post_id     :integer
#


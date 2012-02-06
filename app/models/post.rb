class Post < ActiveRecord::Base
  acts_as_commentable
  acts_as_voteable
  belongs_to :user
  has_one :attachement
  accepts_nested_attributes_for :attachement, :user, :comments, :votes
  
  validates :body, :presence => true  
  validates :user, :presence => true  

end


# == Schema Information
#
# Table name: posts
#
#  id         :integer         not null, primary key
#  body       :string(255)     not null
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#


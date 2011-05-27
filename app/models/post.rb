class Post < ActiveRecord::Base
  acts_as_commentable
  acts_as_voteable
  belongs_to :user
  has_one :attachement
  accepts_nested_attributes_for :attachement
  
  validates :body, :presence => true  
  validates :user, :presence => true  

end

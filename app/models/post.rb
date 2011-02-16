class Post < ActiveRecord::Base
  acts_as_commentable
  belongs_to :user
  validates :body, :presence => true  
  validates :user, :presence => true  


end

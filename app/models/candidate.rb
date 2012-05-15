class Candidate < ActiveRecord::Base
  validates :bio, :presence => true 
  validates :user_id, :presence => true, :uniqueness => true  
  validates :photo, :presence => true  
  acts_as_voteable

  belongs_to :user

  has_attached_file :photo, {
      :styles => { :thumb => "120x120#", :medium => "300x300>" },
      :storage => :s3, 
      :s3_credentials => "#{Rails.root}/config/s3.yml",
      :path => "/candidate_photo/:style/:id/:filename" 
    }

end

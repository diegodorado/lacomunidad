class User < ActiveRecord::Base
  has_attached_file :avatar, 
      :styles => { :medium => "300x300>", :thumb => "50x50#" , :icon => "32x32#" },
      :storage => :s3,
      :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
      :path => "/user_avatars/:style/:id/:filename"
      
  has_many :posts
  has_many :authentications
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :avatar
end

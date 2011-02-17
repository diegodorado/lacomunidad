class User < ActiveRecord::Base

  if Rails.env.production?
    @options = { :storage => :s3, :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                 :path => "/user_avatars/:style/:id/:filename" }
  else
    @options = {:storage => :filesystem}
  end

  has_attached_file :avatar, {
      :styles => { :medium => "150x150>", :thumb => "50x50#" , :icon => "32x32#" }
      }.merge(@options)

  has_many :posts
  has_many :authentications
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :avatar, :name
  

  def apply_omniauth(omniauth)
    self.email = omniauth['email'] if email.blank?
    self.name = omniauth['name'] if name.blank?    
    authentications.build(omniauth)
  end

  def email_required?
    (authentications.empty? || !password.blank?)
  end
  
  def password_required?
    (authentications.empty? || !password.blank?) && super
  end  
  
end

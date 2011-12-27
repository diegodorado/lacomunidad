class User < ActiveRecord::Base
  acts_as_voter
  #has_karma(:posts, :as => :submitter)
  
  if Rails.env.production? || true
    @options = { :storage => :s3, :s3_credentials => "#{Rails.root}/config/s3.yml",
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
  
  def name
    self.email.gsub(/@.*/, '')
  end
  
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


# == Schema Information
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer         default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  avatar_file_name     :string(255)
#  avatar_content_type  :string(255)
#  avatar_file_size     :integer
#  avatar_updated_at    :datetime
#  name                 :string(255)
#


class User < ActiveRecord::Base
  before_create :ensure_attrs

  def ensure_attrs
    #set email first part as name if no name is set
    self.name ||= self.email.gsub(/@.*/, '')
    self.avatar ||= '/assets/default_avatar.png'
  end

  acts_as_voter
  #has_karma(:posts, :as => :submitter)

  has_many :posts
  has_many :authentications
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :confirmable ,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :avatar, :name
  
  def self.user_list
    @users = User.select("id, avatar, email, name").all
    @users.as_json({:only=>[:id, :name, :avatar]})
  end

  def gravatar
      gravatar_id = Digest::MD5::hexdigest(email).downcase  
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=50"
  end

  def facebook_authentication
      authentications.select{|a| a.provider=='facebook'}.first
  end

  def google_authentication
      authentications.select{|a| a.provider=='google_oauth2'}.first
  end
  
#  def email_required?
#    (authentications.empty? || !password.blank?)
#  end
  
  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
  
end



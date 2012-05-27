class User < ActiveRecord::Base
  before_create :ensure_attrs
  has_and_belongs_to_many :roles
  has_one :candidate

  scope :not_me, lambda { |user| {:conditions => "users.id not IN(#{user.id})"} }
   
  def ensure_attrs
    #set email first part as name if no name is set
    self.name ||= self.email.gsub(/@.*/, '')
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

  def avatar
    self[:avatar] || '/assets/default_avatar.png'
  end


  def facebook_authentication
      authentications.select{|a| a.provider=='facebook'}.first
  end

  def google_authentication
      authentications.select{|a| a.provider=='google_oauth2'}.first
  end
  
  def change_pic(provider)
    case provider
      when :gravatar
        self.avatar = gravatar
      when :facebook
        self.avatar = facebook_authentication.image
      when :google
        self.avatar = google_authentication.image
    end
    save
  end
  
  def change_name(value)
    self.name = value
    save!
  end
  
  
#  def email_required?
#    (authentications.empty? || !password.blank?)
#  end
  
  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  #roles stuff
  def role?(role)
    roles.map{|r| r.name}.include? role.to_s
  end

  def add_role(role)
    roles << Role.find_or_create_by_name(role)
  end

  def remove_role(role)
    roles.delete Role.find_by_name role
  end

  def toggle_role(role)
    if role? role
      remove_role role
    else
      add_role role
    end
  end
  
  def friendly_roles_name
    roles.map{|r| r.friendly_name}.to_sentence
  end


  def candidates_votes_count
    Vote.where(
          :voter_id => self.id,
          :voter_type => self.class.name,
          :vote => true,
          :voteable_type => Candidate
        ).count
  end
  
  
end



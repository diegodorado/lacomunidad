class Role < ActiveRecord::Base
  ROLES = {:admin => 'Admin', :editor=>'Editor', :member=>'Miembro'}
  validates :name, :presence => true  
  has_and_belongs_to_many :users
  
  def friendly_name
    Role::ROLES[name.to_sym]
  end
  
end

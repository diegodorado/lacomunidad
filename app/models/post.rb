class Post < ActiveRecord::Base
  acts_as_commentable
  acts_as_voteable
  belongs_to :user
  accepts_nested_attributes_for :user, :comments, :votes
  validates :body, :presence => true  
  validates :user, :presence => true  
  serialize :attach


  def as_json(options)
    options ||= {}
    defaults = {
      :except => [ :updated_at ], 
      :include=> {
        :comments =>{
          :except => [ :updated_at,:commentable_id,:commentable_type, :title ],
        }, 
        :votes=>{
          :except => [ :updated_at,:created_at,:voteable_id,:voteable_type, :voter_type ],
        }
      }
    }
    options = defaults.merge(options)
    result = super(options)
    #horrible hack....what can i do...
    result["created_at"] = created_at.to_yaml.sub('--- ','').sub(/\n/,'')
    result
  end
  
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


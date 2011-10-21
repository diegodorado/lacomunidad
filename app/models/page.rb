class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged
  validates :title, :presence => true, :uniqueness => true

end

# == Schema Information
#
# Table name: pages
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  content    :text
#  slug       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

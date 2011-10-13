require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
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


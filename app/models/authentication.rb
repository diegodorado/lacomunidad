class Authentication < ActiveRecord::Base
  belongs_to :user

  def provider_name
    if provider == 'open_id'
      "OpenID"
    else
      provider.titleize
    end
  end

end


# == Schema Information
#
# Table name: authentications
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  provider   :string(255)
#  uid        :string(255)
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)
#  email      :string(255)
#  nickname   :string(255)
#  image      :string(255)
#  token      :string(255)
#  secret     :string(255)
#


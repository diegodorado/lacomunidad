#require 'faker'
#require 'populator'

@user = User.find(1)

Post.destroy_all

Post.populate(10..20) do |p|
  p.body = Faker::Lorem.sentence
  p.user_id = @user.id
end

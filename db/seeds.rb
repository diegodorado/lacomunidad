Comment.destroy_all
Attachement.destroy_all
Post.destroy_all

=begin

User.destroy_all
Authentication.destroy_all


photo_path = "#{RAILS_ROOT}/test/fixtures/avatars/*.jpg"
Dir.glob(photo_path).entries.each do |e|
  user = User.new
  user.name = Faker::Name.name
  user.email = Faker::Internet.free_email
  user.password = "test"
  user.password_confirmation = "test"
  user.avatar = File.open(e)
  user.save!
end
=end

Post.populate(60..80) do |p|
  p.body = Faker::Lorem.sentences.join(' ')
  p.user_id = User.all.collect(&:id).sort_by{rand}.first
  Comment.populate(0..10) do |c|
    c.commentable_id = p.id
    c.commentable_type = 'Post'
    c.user_id = User.all.collect(&:id).sort_by{rand}.first
    c.comment = Faker::Lorem.sentence
  end
  
end


#random votes
Post.all.each do |p|
  User.all.each do |u|
    srand()
    rand(2) ? u.vote_for(p) : u.vote_against(p)
  end
end


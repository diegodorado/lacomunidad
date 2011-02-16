Comment.destroy_all
Post.destroy_all
#User.destroy_all

Post.populate(10..20) do |p|
  p.body = Faker::Lorem.sentences
  p.user_id = User.all.collect(&:id).sort_by{rand}.first
  Comment.populate(0..8) do |comment|
    comment.commentable_id = p.id
    comment.commentable_type = 'Post'
    comment.user_id = User.all.collect(&:id).sort_by{rand}.first
    comment.comment = Faker::Lorem.sentence
  end
  
end

=begin
10.times do
  user = User.new
  user.username = Faker::Internet.user_name
  user.email = Faker::Internet.email
  user.password = "test"
  user.password_confirmation = "test"
  user.save
end

User.all.each do |user|
  Flit.populate(5..10) do |flit|
    flit.user_id = user.id
    flit.message = Faker::Lorem.sentence
    Comment.populate(2..7) do |comment|
      comment.flit_id = flit.id
      comment.user_id = User.all.collect(&:id).sort_by{rand}.first
      comment.message = Faker::Lorem.sentence
    end
  end
  
  # Add Friends
  3.times do
    user.add_friend(User.all[rand(User.count)])
  end
end
=end

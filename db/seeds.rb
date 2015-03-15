num_users = 40
num_subs = 25
num_posts = 500
num_comments = 800
num_votes = 3000

num_users.times do
  User.create!(email: Faker::Internet.email, password: 'pass')
end

num_subs.times do
  Sub.create!(title: Faker::Lorem.words.join(' '), description: Faker::Lorem.paragraph, user_id: rand(1..num_users))
end

num_posts.times do
  Post.create!(title: Faker::Lorem.words.join(' '), content: Faker::Lorem.paragraph, posted_sub_ids: [rand(1..num_subs), rand(1..num_subs)], user_id: rand(1..num_users))
end

num_comments.times do
  post = rand(1..num_posts)
  Comment.create!(content: Faker::Lorem.paragraph,
                  user_id: rand(1..num_users),
                  commentable_id: post,
                  commentable_type: 'Post',
                  post_id: post)
end

num_comments.times do |i|
  comment = rand(1..num_comments+i)
  Comment.create!(content: Faker::Lorem.paragraph,
                  user_id: rand(1..num_users),
                  commentable_id: comment,
                  commentable_type: 'Comment',
                  post_id: Comment.find(comment).post_id)
end

num_votes.times do |i|
  voter = i % num_users
  v = Vote.new(value: [1,-1][rand(2)], user_id: voter, votable_id: rand(1..num_comments), votable_type: 'Comment')
  v.save if v.valid?
  v2 = Vote.create!(value: [1,-1][rand(2)], user_id: voter, votable_id: rand(1..post), votable_type: 'Post')
  v2.save if v2.valid?
end

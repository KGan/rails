num_users = 10
num_subs = 10
num_posts = 200

num_users.times do
  User.create!(email: Faker::Internet.email, password: 'pass')
end

num_subs.times do
  Sub.create!(title: Faker::Lorem.words.join(' '), description: Faker::Lorem.paragraph, user_id: rand(1..num_users))
end

num_posts.times do
  Post.create!(title: Faker::Lorem.words.join(' '), content: Faker::Lorem.paragraph, sub_id: rand(1..num_subs), user_id: rand(1..num_users))
end

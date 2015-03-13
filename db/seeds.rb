num_users = 20
num_bands = 200
num_albums = 300
num_tracks = 400

num_users.times do |i|
  User.create!(:email => "User_#{i}", :password => "pass")
end

num_bands.times do |i|
  Band.create!(:name => "#{Faker::Name.name}_#{i}", :user_id => rand(1..num_users) )
end

num_albums.times do |i|
  Album.create!(:title => "#{Faker::Name.name}_#{i}",
                :user_id => rand(1..num_users),
                :band_id => rand(1..num_bands),
                :recording_type => Album::RECORD_TYPES.sample
  )
end

num_tracks.times do |i|
  Track.create!(title: "#{Faker::Name.name}_#{i}",
                :user_id => rand(1..num_users),
                :album_id => rand(1..num_albums),
                :track_type => Track::TRACK_TYPES.sample,
                :lyrics => Faker::Lorem.paragraphs(5)
  )
end
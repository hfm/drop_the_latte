namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    users = User.all(limit: 6)
    50.times do
      took_date = rand(10.years).ago
      users.each { |user| user.photos.create!(took_date: took_date) }
    end

    users = User.all(limit: 20)
    10.times do |n|
      users.each do |user|
        user.photos.each_with_index do |photo, m|
          comment = "おもちかわいい #{n+1} #{m+1}"
          photo.comments.create!(content: comment, user_id:user.id)
        end
      end
    end
  end
end

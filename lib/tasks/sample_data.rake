namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    39.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    users = User.all(limit: 6)
    10.times do
      content = File.new(Rails.root + 'lib/tasks/omochi.jpg')
      took_date = rand(10.years).ago
      users.each { |user| user.photos.create!(took_date: took_date, content: content) }
    end

    users.each do |user|
      user.photos.each_with_index do |photo, m|
        5.times do |n|
          comment = "おもちかわいい #{n+1}-#{m+1}"
          created_at = rand(1.years).ago
            photo.comments.create!(content: comment, user_id:user.id, other_id: rand(20) + 1, created_at: created_at)
        end
      end
    end
  end
end

FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
  end

  factory :photo do
    content File.new(Rails.root + 'spec/support/image/test.jpg')
    took_date DateTime.new(2011, 12, 24, 00, 00, 00).strftime("%Y-%m-%d %H:%M:%S %Z")
    user
  end

  factory :comment do
    content "おもちかわいい"
    photo_id "1"
    user_id "1"
  end
end

FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
  end

  factory :photo do
    took_date DateTime.new(2011, 12, 24, 00, 00, 00).strftime("%Y-%m-%d %H:%M:%S %Z")
    user
  end

  factory :comment do
    content "おもちかわいい"
    user
    photo
  end
end

FactoryGirl.define do
  factory :draft do
    sequence(:title) { |n| "My Short Story #{n}" }
    genre 'Fantasy'
    #How to do this? make_public 'True'
    summary 'This is a short story'
    # content--how to do this?

    user
  end

  factory :critique do
    comment 'I liked this story'

    draft
    user
  end

  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    first_name 'Jane'
    last_name 'Smith'
    password 'password'
    role 'member'
    profile_photo { File.open(File.join(Rails.root, '/spec/support/example.jpg')) }
  end
end

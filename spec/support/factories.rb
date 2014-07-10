FactoryGirl.define do
  factory :draft do
    sequence(:title) { |n| "My Short Story #{n}" }
    genre 'Fantasy'
    restriction 'Public'
    summary 'This is a short story'
    body 'Body' #How to do this with ckeditor?  Will this work?

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
    username 'username'
    password 'password'
    role 'member'
    profile_photo { File.open(File.join(Rails.root, '/spec/support/example.jpg')) }
  end
end

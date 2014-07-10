require 'rails_helper'

feature 'user signs up', %Q(
  As a user
  I want to sign up
  So that I can interact with other users
) do

# Acceptance criteria:
# I should not be signed in already.
# I need to see a link to sign up on the homepage.
# After I log in I should not see a sign up link; instead I should see a link to sign out.
# I must provide a username.
# My username must be unique.
# I must provide a first name.
# I must provide a last name.
# I must provide an email.
# My email must be unique.
# I must create a password.
# I must confirm my password.
# I can optionally provide a profile photo.
# The default role for a new user is member.
# I should get a success message if it is posted successfully.
# I should get an error message if it is not posted successfully.

  scenario 'user signs up' do
    user = FactoryGirl.build(:user)

    visit '/'
    click_link 'Sign Up'
    fill_in 'First Name', with: user.first_name
    fill_in 'Last Name', with: user.last_name
    fill_in 'Username', with: user.username
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password Confirmation', with: user.password
    click_button 'Sign Up'

    expect(page).to have_content('Sign Out')
    expect(page).to_not have_content('Sign Up')
    expect(page).to_not have_content('Sign In')
  end

  scenario 'user signs up with non-matching passwords' do
    user = FactoryGirl.build(:user)

    visit '/'
    click_link 'Sign Up'
    fill_in 'First Name', with: user.first_name
    fill_in 'Last Name', with: user.last_name
    fill_in 'Username', with: user.username
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password Confirmation', with: 'wrong'
    click_button 'Sign Up'

    expect(page).to have_content("confirmation doesn't match")

  end

  scenario 'user fails to enter required information' do
    user = FactoryGirl.build(:user)

    visit '/'
    click_link 'Sign Up'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password Confirmation', with: user.password
    click_button 'Sign Up'

    expect(page).to have_content("can't be blank") #How to do this multiple times?
  end

  scenario 'user signs up with profile photo' do #Does this need to be its own test?
    user = FactoryGirl.build(:user)

    visit '/'
    click_link 'Sign Up'
    fill_in 'First Name', with: user.first_name
    fill_in 'Last Name', with: user.last_name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password Confirmation', with: user.password
    attach_file 'Profile Photo', File.join(Rails.root, '/spec/support/example.jpg')
    click_button 'Sign Up'

    expect(page).to have_content('Sign Out')
    expect(page).to_not have_content('Sign Up')
  end
end

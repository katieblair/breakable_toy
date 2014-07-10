require 'rails_helper'

feature 'user signs in', %Q(
  As a user
  I want to sign in
  So that I can access my profile and interact with other users
) do

# Acceptance criteria:
# I should not be signed in already.
# I need to see a link to sign in on the homepage.
# After I log in I should not see a sign in link; instead I should see a link to sign out.
# I must provide my email.
# I must provide the correct password.
# I should get a success message if it is posted successfully.
# I should get an error message if it is not posted successfully.

  scenario 'user signs in' do
    user = FactoryGirl.create(:user)
    visit '/'
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content('Sign Out')
    expect(page).to_not have_content('Sign Up')
    expect(page).to_not have_content('Sign In')
  end

  scenario 'user does not provide email' do
    visit '/'
    click_link 'Sign In'
    fill_in 'Email', with: ''
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content('Invalid email or password')
  end

  scenario 'user does not provide password' do
    visit '/'
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: ''
    click_button 'Sign In'

    expect(page).to have_content('Invalid email or password')
  end

  scenario 'user provides incorrect email' do
    visit '/'
    click_link 'Sign In'
    fill_in 'Email', with: 'wrong@example.com'
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content('Invalid email or password')
  end

  scenario 'user provides incorrect password' do
    visit '/'
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'wrong'
    click_button 'Sign In'

    expect(page).to have_content('Invalid email or password')
  end

end

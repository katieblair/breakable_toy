require 'rails_helper'

feature 'user views all genres', %Q(
  As a user
  I want to view a list of all genres
  So I can find stories based on my interests
) do

# Acceptance criteria:
# I must be signed in to do this.
# I should be able to see all the genres.
# I should be able to click on the name of each genre and be taken to its show page.

  scenario 'authenticated user views all genres' do
    @user = FactoryGirl.create(:user)
    login(@user)
    genres = FactoryGirl.create_list(:genre, 3)

    visit genres_path

    genres.each do |genre|
      expect(page).to have_content genre.name
    end
  end

  scenario 'unauthenticated user cannot view all genres' do
    genres = FactoryGirl.create_list(:genre, 3)

    visit genres_path

    expect(page).to have_content('You need to sign in')
    genres.each do |genre|
      expect(page).to_not have_content genre.name
    end
  end
end

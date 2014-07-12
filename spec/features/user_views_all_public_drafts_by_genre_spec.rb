require 'rails_helper'

feature 'user views all public drafts of one genre', %Q(
  As a user
  I want to view a list of all public drafts by genre
  So I can filter drafts based on my interests
) do

# Acceptance criteria:
# I must be signed in to do this.
# I should see all drafts that belong to that genre.
# I should see each draft’s title and author, and should see a summary if it was provided.
# I should not see a draft that belongs to a different genre.
# I should not see any drafts that are classified as private.
# I should be able to click on a link for each individual draft and be taken to its show page.

  scenario 'authenticated user views all public drafts of one genre' do
    genre = FactoryGirl.create(:genre)
    drafts = FactoryGirl.create_list(:draft, 3, genre: genre)
    @user = FactoryGirl.create(:user)
    login(@user)

    visit genre_path(genre)

    expect(page).to have_content(genre.name)

    drafts.each do |draft|
      expect(page).to have_content(draft.title)
      expect(page).to have_content(draft.user.username)
      expect(page).to have_content(draft.summary)
    end
  end

  scenario 'authenticated user does not see draft of another genre' do
    genre = FactoryGirl.create(:genre)
    wrong_draft = FactoryGirl.create(:draft)

    expect(page).to_not have_content(wrong_draft.title)
    expect(page).to_not have_content(wrong_draft.summary)
  end

  scenario 'unauthenticated user cannot view drafts' do
    genre = FactoryGirl.create(:genre)
    drafts = FactoryGirl.create_list(:draft, 3, genre: genre)

    visit genre_path(genre)

    expect(page).to have_content('You need to sign in')
  end
end

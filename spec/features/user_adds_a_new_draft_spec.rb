require 'rails_helper'

feature 'user adds a new draft', %Q(
  As a user
  I want to post a draft
  So that other users can critique it
) do

# Acceptance criteria:
# I need to be signed in to do this.
# I must provide a title.
# I must provide a body.
# I must select a genre.
# I must specify if it is public or not.
# I can optionally provide a summary.
# I should get a success message if it is posted successfully.
# I should get an error message if it is not posted successfully.

# Add logic for linking a draft to a group!
# This will require you to split the authenticated user test into two tests
# One for public draft and one for group-only draft
# For now do not use groups and assume all drafts are public

# Limit summary length and add a test for that

  context 'authenticated user' do
    before :each do
      @user = FactoryGirl.create(:user)
      login(@user)
    end

    scenario 'authenticated user adds a new draft' do
      draft = FactoryGirl.create(:draft)
      visit new_draft_path

      fill_in 'Title', with: draft.title
      select draft.genre, from: 'Genre'
      select draft.restriction, from: 'Restriction'
      fill_in 'Summary', with: draft.summary
      fill_in 'Body', with: draft.body
      click_on 'Create Draft'

      expect(page).to have_content('Success!')
      expect(page).to have_content draft.title
      expect(page).to have_content draft.user.username
      expect(page).to have_content draft.genre
      expect(page).to have_content draft.restriction
      expect(page).to have_content draft.summary
      expect(page).to have_content draft.body
    end

    scenario 'authenticated user does not supply required content' do
      draft = FactoryGirl.create(:draft)
      visit new_draft_path

      click_on 'Create Draft'

      expect(page).to_not have_content('Success!')
      expect(page).to have_content("Title can't be blank")
      expect(page).to have_content("Summary can't be blank")
      expect(page).to have_content("Body can't be blank")
    end
  end

  scenario 'unauthenticated user' do
    visit new_draft_path

    expect(page).to have_content('You need to sign in')
  end
end

# fill_in 'Body', with: draft.body
# fill_in '.cke_contents_ltr', with: draft.body

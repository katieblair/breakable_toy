require 'rails_helper'

feature 'user edits a draft', %Q(
  As a user
  I want to edit an existing draft
  So I can make the most current version available for critiques
) do

# Acceptance criteria
# I must be signed in.
# The draft to be edited must belong to me.
# The title field must still be filled in.
# The genre must still be selected.
# The summary must still be filled in.
# The body field must still be filled in.
# I should get a success message if it is edited successfully.
# I should get an error message if it is not edited successfully.

  context 'authenticated user' do
    before :each do
      @user = FactoryGirl.create(:user)
      login(@user)
    end

    scenario 'authorized user edits own draft' do
      draft = FactoryGirl.create(:draft, user: @user)
      visit edit_draft_path(draft)

      fill_in 'Title', with: draft.title
      select draft.genre, from: 'Genre'
      select draft.restriction, from: 'Restriction'
      fill_in 'Summary', with: draft.summary
      fill_in 'Body', with: draft.body
      click_on 'Update Draft'

      expect(page).to have_content('Success!')
      expect(page).to have_content draft.title
      expect(page).to have_content draft.user.username
      expect(page).to have_content draft.genre
      expect(page).to have_content draft.restriction
      expect(page).to have_content draft.summary
      expect(page).to have_content draft.body
    end

    scenario 'authorized user see error message if form incomplete' do
      draft = FactoryGirl.create(:draft, user: @user)
      visit edit_draft_path(draft)

      fill_in 'Title', with: ''
      fill_in 'Summary', with: ''
      fill_in 'Body', with: ''
      click_on 'Update Draft'

      expect(page).to_not have_content('Success!')
      expect(page).to have_content("Title can't be blank")
      expect(page).to have_content("Summary can't be blank")
      expect(page).to have_content("Body can't be blank")
    end

    scenario 'unauthorized user cannot edit draft' do
      draft = FactoryGirl.create(:draft)
      visit draft_path(draft)

      expect(page).to_not have_content('Edit')
    end
  end

  scenario 'unauthenticated user cannot edit draft' do
    draft = FactoryGirl.create(:draft)
    visit draft_path(draft)

    expect(page).to_not have_content('Edit')
  end
end

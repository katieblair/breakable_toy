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
# The content field must still be filled in.
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
      choose 'Genre', with: draft.genre #Dropdown menu
      choose 'Make public?', with: draft.restriction #How to do this?
      fill_in 'Summary', with: draft.summary
      fill_in 'Content', with: draft.content
      click_on 'Update Draft'

      expect(page).to have_content('Success!')
      expect(page).to have_content draft.title
      expect(page).to have_content draft.user.username
      expect(page).to have_content draft.genre
      expect(page).to have_content draft.restriction #How to do this?
      expect(page).to have_content draft.summary
      expect(page).to have_content draft.content
    end

    scenario 'authorized user see error message if form incomplete' do
      draft = FactoryGirl.create(:draft, user: @user)
      visit edit_draft_path(draft)

      fill_in 'Title', with: ''
      choose 'Genre', with: #How to do this???
      choose 'Make public?', with: #How to do this???
      fill_in 'Summary', with: ''
      fill_in 'Content', with: ''
      click_on 'Update Draft'

      expect(page).to_not have_content('Success!')
      expect(page).to have_content("Title can't be blank")
      expect(page).to have_content("Genre can't be blank") #Is this true with a dropdown?
      expect(page).to have_content("Make public? can't be blank")
      expect(page).to have_content("Summary can't be blank")
      expect(page).to have_content("Content can't be blank")
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

require 'rails_helper'

feature 'user edits a critique', %Q(
  As a user
  I want to edit my critique
  So I can share more of my thoughts about someone’s draft
) do

# Acceptance criteria:
# I need to be signed in to do this.
# The critique must belong to me.
# The comment field must still be filled in.
# I should get a success message if it is edited successfully.
# I should get an error message if it is not edited successfully.

  context 'authenticated user' do
    before :each do
      @user = FactoryGirl.create(:user)
      login(@user)
    end

    scenario 'authorized user edits own critique' do
      draft = FactoryGirl.create(:draft)
      critique = FactoryGirl.create(:critique, draft: draft, user: @user)
      visit edit_critique_path(critique)

      fill_in 'Comment', with: critique.comment
      click_on 'Update Critique'

      expect(page).to have_content('Success!')
      expect(page).to have_content critique.comment
    end

    scenario 'authorized user cannot leave comment field blank' do
      draft = FactoryGirl.create(:draft)
      critique = FactoryGirl.create(:critique, draft: draft, user: @user)
      visit edit_critique_path(critique)

      fill_in 'Comment', with: ''
      click_on 'Update Critique'

      expect(page).to_not have_content('Success!')
      expect(page).to have_content("Comment can't be blank")
    end

    scenario 'unauthorized user cannot edit critique belonging to other user' do
      draft = FactoryGirl.create(:draft)
      critique = FactoryGirl.create(:critique, draft: draft)
      visit draft_path(draft)

      expect(page).to_not have_content 'Edit'
    end
  end

  scenario 'unauthenticated user cannot edit critique' do
    draft = FactoryGirl.create(:draft)
    critique = FactoryGirl.create(:critique, draft: draft)
    visit draft_path(draft)

    expect(page).to_not have_content 'Edit'
  end
end

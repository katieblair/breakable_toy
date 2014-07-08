require 'rails_helper'

feature 'user deletes a draft', %Q(
  As a user
  I want to delete an existing draft
  So that it will no longer be available for other users to view or critique
) do

# Acceptance criteria
# The draft to be deleted must belong to me.
# Deleting the draft should also delete all of its critiques.
# I should get a success message if it is deleted successfully.
# I should get an error message if it is not deleted successfully.

  context 'authenticated user' do
    before :each do
      @user = FactoryGirl.create(:user)
      login(@user)
    end

    scenario 'authorized user deletes draft' do
      draft = FactoryGirl.create(:draft, user: @user)
      visit draft_path(draft)

      click_on 'Delete'

      expect(page).to have_content 'Deleted'
    end

    scenario 'unauthorized user cannot delete draft' do
      draft = FactoryGirl.create(:draft)
      visit draft_path(draft)

      expect(page).to_not have_content('Delete')
    end
  end

  scenario 'unauthenticated user cannot delete draft' do
    draft = FactoryGirl.create(:draft)
    visit draft_path(draft)

    expect(page).to_not have_content('Delete')
  end
end

require 'rails_helper'

feature 'user deletes a critique', %Q(
  As a user
  I want to delete a critique
  So that other users can no longer see it
) do

# Acceptance criteria:
# I need to be signed in to do this.
# The draft to be deleted must belong to me.
# I should get a success message if it is deleted successfully.
# I should get an error message if it is not deleted successfully.

  context 'authenticated user' do
    before :each do
      @user = FactoryGirl.create(:user)
      login(@user)
      @draft = FactoryGirl.create(:draft)
    end

    scenario 'authorized user deletes own critique' do
      critique = FactoryGirl.create(:critique, draft: draft, user: @user)
      visit draft_path(@draft)

      click_on 'Delete'

      expect(page).to have_content('Deleted')
    end

    scenario 'unauthorized user cannot delete critique belonging to other user' do
      critique = FactoryGirl.create(:critique, draft: @draft)
      visit draft_path(@draft)

      expect(page).to_not have_content('Delete')
    end
  end

  scenario 'unauthenticated user cannot delete critique' do
    draft = FactoryGirl.create(:draft)
    critique = FactoryGirl.create(:critique, draft: draft)
    visit draft_path(draft)

    expect(page).to_not have_content('Delete')
  end
end

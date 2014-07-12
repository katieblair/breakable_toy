require 'rails_helper'

feature 'user adds a new critique', %Q(
  As a user
  I want to critique someone else's draft
  So that the author can benefit from my feedback
) do

# Acceptance criteria:
# I need to be signed in to do this.
# I must provide a comment.
# I should get a success message if it is posted successfully.
# I should get an error message if it is not posted successfully.

  context 'authenticated user' do
    before :each do
      @user = FactoryGirl.create(:user)
      login(@user)
      @draft = FactoryGirl.create(:draft)
      visit draft_path(@draft)
    end

    scenario 'user adds a new critique' do
      critique = FactoryGirl.create(:critique)

      fill_in 'Comment', with: critique.comment
      click_on 'Create Critique'

      expect(page).to have_content('Success!')
      expect(page).to have_content critique.comment
    end

    scenario 'user does not supply a comment' do
      critique = FactoryGirl.create(:critique)

      click_on 'Create Critique'

      expect(page).to_not have_content('Success')
      expect(page).to have_content("Comment can't be blank")
    end
  end

  scenario 'unauthenticated user cannot add review' do
    draft = FactoryGirl.create(:draft)
    visit draft_path(draft)

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end

require 'rails_helper'

feature 'user views all public drafts', %Q(
  As a user
  I want to view a list of all public drafts
  So I can read and comment on other writers’ work
) do

# Acceptance criteria:
# I must be signed in to do this.
# I should be able to view the title of each public draft.
# I should be able to view the author of each public draft.
# I should be able to view the genre of each public draft.
# I should be able to view a summary of each public draft (if provided).
# I should be able to click on a link for each individual draft and be taken to its show page.
# I should not see any private drafts.

  scenario 'authenticated user views all public drafts' do
    drafts = FactoryGirl.create_list(:draft, 3)
    user = FactoryGirl.create(:user)
    login(user)

    visit drafts_path

    drafts.each do |draft|
      expect(page).to have_content(draft.title)
      expect(page).to have_content(draft.user.username)
      expect(page).to have_content(draft.genre)
      expect(page).to have_content(draft.summary)
    end
  end

  #scenario 'authenticated user cannot view private draft' do
    #Do I need to write this test?
  #end

  scenario 'unauthenticated user cannot view all public drafts' do
    drafts = FactoryGirl.create_list(:draft, 3)
    visit drafts_path

    expect(page).to have_content('You need to sign in')
  end
end

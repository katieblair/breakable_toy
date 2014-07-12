require 'rails_helper'

feature 'users views draft show page', %Q(
  As a user
  I want to view the page for an individual draft
  So that I can read it and its critiques
) do

# Acceptance criteria:
# I must be signed in to do this.
# If it is a public draft I should be able to see it and its critiques.
# If it is a private draft I must belong to the author’s group in order to see it and its critiques.
# If it is neither public nor written by a member of my group I should not be able to see it.
# If I have the proper permissions to see the draft I should also see all of its critiques.
# I should see a form to submit a new critique.

  scenario 'authenticated user views public draft show page' do
    draft = FactoryGirl.create(:draft)
    critiques = FactoryGirl.create_list(:critique, 3, draft: draft)
    @user = FactoryGirl.create(:user)
    login(@user)

    visit draft_path(draft)

    expect(page).to have_content draft.title
    expect(page).to have_content draft.user.username
    expect(page).to have_content draft.genre.name
    expect(page).to have_content draft.restriction
    expect(page).to have_content draft.summary
    expect(page).to have_content draft.body

    critiques.each do |critique|
      expect(page).to have_content critique.comment
    end
  end

  scenario 'unauthenticated user cannot view public draft show page' do
    draft = FactoryGirl.create(:draft)
    critiques = FactoryGirl.create_list(:critique, 3, draft: draft)

    visit draft_path(draft)

    expect(page).to have_content('You need to sign in')
  end

  # scenario 'unauthorized user cannot view private draft show page' do

  # end

end

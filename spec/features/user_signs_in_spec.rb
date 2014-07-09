require 'rails_helper'

feature 'user signs in', %Q(
  As a user
  I want to sign in
  So that I can access my profile and interact with other users
) do

# Acceptance criteria:
# I should not be signed in already.
# I need to see a link to sign in on the homepage.
# After I log in I should not see a sign in link; instead I should see a link to sign out.
# I must provide my email.
# I must provide the correct password.
# I should get a success message if it is posted successfully.
# I should get an error message if it is not posted successfully.

end

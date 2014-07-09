require 'rails_helper'

feature 'user signs up', %Q(
  As a user
  I want to sign up
  So that I can interact with other users
) do

# Acceptance criteria:
# I should not be signed in already.
# I need to see a link to sign up on the homepage.
# After I log in I should not see a sign up link; instead I should see a link to sign out.
# I must provide a username.
# My username must be unique.
# I must provide a first name.
# I must provide a last name.
# I must provide an email.
# My email must be unique.
# I must create a password.
# I must confirm my password.
# I can optionally provide a profile photo.
# The default role for a new user is member.
# I should get a success message if it is posted successfully.
# I should get an error message if it is not posted successfully.

end

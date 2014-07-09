require 'rails_helper'

feature 'user signs out', %Q(
  As a user
  I want to sign out
  So that no one can hack my account on my computer
) do

# Acceptance criteria:
# I must be signed in to do this.
# After I sign out I should not see a sign out link; instead I should see links to sign up or sign in.
# I should get a success message if I am signed out successfully.
# I should get an error message if I am not signed out successfully.

end

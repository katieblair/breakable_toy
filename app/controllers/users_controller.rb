class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @memberships = Membership.where(user: @user)
    @drafts = Draft.where(user: @user)
  end
end

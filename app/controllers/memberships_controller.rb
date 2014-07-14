class MembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_moderator, only: :confirm

  def create
    @group =Group.find(params[:group_id])
    @membership = Membership.new(user: current_user, group: @group)
    if @membership.save
      flash[:notice] = "Membership request saved."
      redirect_to group_path(@group)
    else
      flash[:notice] = "Membership request not saved."
      render 'groups/show'
    end
  end

  def destroy
    @membership = Membership.find(params[:id])
    @group = @membership.group
    if @membership.destroy
      flash[:notice] = "Membership deleted."
      redirect_to group_path(@group)
    else
      flash[:notice] = "Error"
      render 'groups/show'
    end
  end

  def confirm
    @group = Group.find(params[:id])
    @memberships = Membership.where(group: @group)
  end

  private

  def membership_params
    params.require(:membership).permit(:user_id, :group_id)
  end

  def authorize_moderator
    @group = Group.find(params[:id])
    if current_user.id != @group.user_id
      flash[:notice] = 'You are not authorized to do that.'
      redirect_to group_path(@group)
    end
  end
end

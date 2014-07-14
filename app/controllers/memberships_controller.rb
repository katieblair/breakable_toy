class MembershipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @membership = Membership.new(membership_params)
    @membership.user_id = current_user.id
    @group = Group.find(params[:id])
    if @membership.save
      flash[:notice] = "Membership saved."
      redirect_to group_path(@group)
    else
      flash[:notice] = "Membership not saved."
      render 'groups/show'
    end
  end

  def destroy
    @membership = Membership.find(params[:id])
    @group = Group.find(params[:id])
    if @member.destroy
      flash[:notice] = "Membership deleted."
      redirect_to group_path(@group)
    else
      flash[:notice] = "Error"
      render 'groups/show'
    end
  end

  private

  def membership_params
    params.require(:membership).permit(:user_id, :group_id)
  end
end

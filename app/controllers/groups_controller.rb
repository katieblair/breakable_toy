class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_moderator, only: [:edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @memberships = Membership.where(group: @group)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user_id = current_user.id
    if @group.save
      flash[:notice] = 'Success!'
      redirect_to groups_path
    else
      flash[:notice] = 'Error'
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    if @group.update(group_params)
      flash[:notice] = 'Success!'
      redirect_to group_path(@group)
    else
      render :edit
    end
  end

  def destroy
    if @group.destroy
      flash[:notice] = 'Deleted'
      redirect_to groups_path
    else
      flash[:notice] = 'Error'
      render :show
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :description)
  end

  def authorize_moderator
    @group = Group.find(params[:id])
    if current_user.id != @group.user_id
      flash[:notice] = 'You are not authorized to do that.'
      redirect_to group_path(@group)
    end
  end
end

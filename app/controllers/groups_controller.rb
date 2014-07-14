class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:notice] = 'Success!'
      redirect_to groups_path
    else
      flash[:notice] = 'Error'
      render :new
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :description)
  end
end

class DraftsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_to_edit, only: [:edit, :update, :destroy]

  def index
    @drafts = Draft.order("created_at DESC")
  end

  def show
    @draft = Draft.find(params[:id])
    @critiques = Critique.where(draft: @draft)
    @critique = Critique.new
  end

  def new
    @draft = Draft.new
  end

  def create
    @draft = Draft.new(draft_params)
    @draft.user_id = current_user.id
    if @draft.save
      flash[:notice] = 'Success!'
      redirect_to drafts_path
    else
      flash[:notice] = 'Error'
      render :new
    end
  end

  def edit
    @draft = Draft.find(params[:id])
  end

  def update
    if @draft.update(draft_params)
      flash[:notice] = 'Success!'
      redirect_to draft_path(@draft)
    else
      render :edit
    end
  end

  def destroy
    if @draft.destroy
      flash[:notice] = 'Deleted'
      redirect_to drafts_path
    else
      flash[:notice] = 'Error'
      render :show
    end
  end

  private

  def draft_params
    params.require(:draft).permit(:title, :genre_id, :restriction, :summary, :body)
  end

  def authorize_to_edit
    @draft = Draft.find(params[:id])
    if current_user != @draft.user #|| current_user.role != 'admin'
      flash[:notice] = 'You are not authorized to do that.'
      redirect_to draft_path(@draft)
    end
  end
end

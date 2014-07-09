class DraftsController < ApplicationController
  def index
    @drafts = Draft.order("created_at DESC")
  end

  def show
    @draft = Draft.find(params[:id])
  end

  def new
    @draft = Draft.new
  end

  def create
    @draft = Draft.new(draft_params)
    if @draft.save
      redirect_to drafts_path
      flash[:notice] = 'Success!'
    else
      render :new
    end
  end

  def edit
    @draft = Draft.find(params[:id])
  end

  def update
    @draft = Draft.find(params[:id])
    if @draft.update(draft_params)
      redirect_to draft_path(@draft)
      flash[:notice] = 'Success!'
    else
      render :edit
    end
  end

  def destroy
    @draft = Draft.find(params[:id])
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
    params.require(:draft).permit(:title, :restriction, :summary, :body)
  end
end

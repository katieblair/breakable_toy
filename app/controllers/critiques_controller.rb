class CritiquesController < ApplicationController
  before_action :authenticate_user!

  def create
    @critique = Critique.new(critique_params)
    @critiques = Critique.order(created_at: :desc)
    @draft = Draft.find(params[:draft_id])
    @critique.draft = @draft
    if @critique.save
      flash[:notice] = 'Success!'
      redirect_to draft_path(@draft)
    else
      flash[:notice] = 'Your critique was not saved.'
      render 'drafts/show'
    end
  end

  def edit
    @critique = Critique.find(params[:id])
  end

  def update
    @critique = Critique.find(params[:id])
    @draft = @critique.draft
    if @critique.destroy
      flash[:notice] = 'Deleted'
      redirect_to draft_path(@draft)
    else
      flash[:notice] = 'Error'
      render 'drafts/show'
    end
  end

  private

  def critique_params
    params.require(:critique).permit(:comment)
  end
end

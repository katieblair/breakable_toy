class HomesController < ApplicationController
  def index
    if current_user
      redirect_to drafts_path
    end
  end

  def about
  end

  def developer
  end

  def faqs
  end
end

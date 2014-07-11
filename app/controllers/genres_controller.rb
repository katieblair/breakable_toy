class GenresController < ApplicationController
  def index
    @genres = Genre.all
  end

  def show
    @genre = Genre.find(params[:id])
    @drafts = Draft.where(genre_id: @genre_id)
  end
end

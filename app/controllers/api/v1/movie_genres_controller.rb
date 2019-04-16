class Api::V1::MovieGenresController < ApplicationController
  def index
    @movie_genres = MovieGenre.all
    render json: @movie_genres

  end

  def show
    @movie_genre = MovieGenre.find(params[:id])
    render json: @movie_genre
  end
end

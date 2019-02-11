class Api::V1::MoviesController < ApplicationController
  def index
    @movies = Movie.all
    render json: @movies

  end

  def show
    @mood = Mood.find(params[:id])
    render json: @mood
  end

  def update
    @movie.update(movie_params)
    if @movie.save
      render json: @movie, status: :accepted
    else
      render json: {errors: @movie.errors.full_messages }, status: :unprocessible_entity
    end
  end

  private

  def movie_params
    params.permit( :title, :length, :release, :image, :description)
  end

  def find_movie
    @move = Movie.find(params[:id])
  end

end

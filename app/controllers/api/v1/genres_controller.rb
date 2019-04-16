class Api::V1::GenresController < ApplicationController
  def index
    @genres = Genre.all
    render json: @genres

  end

  def show
    @genre = Genre.find(params[:id])
    render json: @genre
  end

  def update
    @genre.update(genre_params)
    if @genre.save
      render json: @genre, status: :accepted
    else
      render json: {errors: @genre.errors.full_messages }, status: :unprocessible_entity
    end
  end

  private

  def genre_params
    params.permit( :name, :apiId)
  end
end

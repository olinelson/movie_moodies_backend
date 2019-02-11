class Api::V1::MovieMoodsController < ApplicationController
  def index
    @movie_moods = MovieMood.all
    render json: @movie_moods

  end

  def show
    @movie_moods = MovieMood.find(params[:id])
    render json: @movie_moods
  end

  # def update
  #   @mood.update(mood_params)
  #   if @mood.save
  #     render json: @mood, status: :accepted
  #   else
  #     render json: {errors: @mood.errors.full_messages }, status: :unprocessible_entity
  #   end
  # end

  private

  # def mood_params
  #   params.permit( :name, :image)
  # end
end

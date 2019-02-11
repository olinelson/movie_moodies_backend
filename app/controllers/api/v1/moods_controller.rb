class Api::V1::MoodsController < ApplicationController
  def index
    @moods = Mood.all
    render json: @moods

  end

  def show
    @mood = Mood.find(params[:id])
    render json: @mood
  end

  def update
    @mood.update(mood_params)
    if @mood.save
      render json: @mood, status: :accepted
    else
      render json: {errors: @mood.errors.full_messages }, status: :unprocessible_entity
    end
  end

  private

  def mood_params
    params.permit( :name, :image)
  end

  
end

class MoodSerializer < ActiveModel::Serializer
  attributes :id, :name, :image
  has_many :movie_moods
  has_many :movies, through: :movie_moods
end

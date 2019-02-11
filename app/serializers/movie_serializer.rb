class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :length, :release, :image, :description
  has_many :movie_moods
  has_many :moods, through: :movie_moods
end

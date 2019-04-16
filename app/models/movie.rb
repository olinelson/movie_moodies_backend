class Movie < ApplicationRecord
  has_many :movie_moods
  has_many :moods, through: :movie_moods
  has_many :movie_genres
  has_many :genres, through: :movie_genres
  has_many :videos

end

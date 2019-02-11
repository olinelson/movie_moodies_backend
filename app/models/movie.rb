class Movie < ApplicationRecord
  has_many :movie_moods
  has_many :moods, through: :movie_moods
end

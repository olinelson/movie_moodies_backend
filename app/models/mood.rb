class Mood < ApplicationRecord
  has_many :movie_moods
  has_many :movies, through: :movie_moods
end

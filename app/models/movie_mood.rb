class MovieMood < ApplicationRecord
  belongs_to :movie
  belongs_to :mood
end

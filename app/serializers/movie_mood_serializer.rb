class MovieMoodSerializer < ActiveModel::Serializer
  attributes :id, :movie_id, :mood_id
  belongs_to :movie
  belongs_to :mood
end

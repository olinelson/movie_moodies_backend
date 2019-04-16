class VideoSerializer < ActiveModel::Serializer
  attributes :id, :domain, :url_key, :movie_id, :name
  belongs_to :movie
end

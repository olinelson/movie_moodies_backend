class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :length, :release, :image, :description
end

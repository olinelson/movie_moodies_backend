class AddGenreIdsToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :genres, :string
  end
end

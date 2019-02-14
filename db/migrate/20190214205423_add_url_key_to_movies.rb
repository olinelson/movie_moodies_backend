class AddUrlKeyToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :url_key, :string
  end
end

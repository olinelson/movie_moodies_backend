class AddApiIdToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :apiId, :string
  end
end

class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :length
      t.string :release
      t.string :image
      t.string :description

      t.timestamps
    end
  end
end

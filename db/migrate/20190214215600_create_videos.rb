class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.string :name
      t.string :domain
      t.string :url_key
      t.integer :movie_id

      t.timestamps
    end
  end
end

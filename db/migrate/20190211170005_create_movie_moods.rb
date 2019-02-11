class CreateMovieMoods < ActiveRecord::Migration[5.2]
  def change
    create_table :movie_moods do |t|
      t.integer :movie_id
      t.integer :mood_id

      t.timestamps
    end
  end
end

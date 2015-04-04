class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.integer :movie_id

      t.timestamps
    end
  end
end

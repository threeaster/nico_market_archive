class AddColumnToHistory < ActiveRecord::Migration
  def change
    add_column :histories, :date, :datetime, after: :movie_id
  end
end

class AddMakerAndBuyNumAndClickedNumAndClickedAtThisMovieToProducts < ActiveRecord::Migration
  def change
    add_column :products, :maker, :string
    add_column :products, :buy_num, :integer
    add_column :products, :clicked_num, :integer
    add_column :products, :clicked_at_this_movie, :integer
  end
end

class CreateHistoriesProducts < ActiveRecord::Migration
  def change
    create_table :histories_products, id: false do |t|
      t.references :history, index: true, null: false
      t.references :product, index: true, null: false
    end
  end
end

class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :shop_id
      t.string :product_id

      t.timestamps
    end
  end
end

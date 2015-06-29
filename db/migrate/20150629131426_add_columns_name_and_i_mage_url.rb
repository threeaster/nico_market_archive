class AddColumnsNameAndIMageUrl < ActiveRecord::Migration
  def change
    add_column :products, :product_name, :string
    add_column :products, :product_image_url, :string
  end
end

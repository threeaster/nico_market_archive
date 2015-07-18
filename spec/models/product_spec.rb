require 'rails_helper'

RSpec.describe Product, :type => :model do
  describe 'enum' do
    describe 'amazonはproduct_idが1である' do
      let!(:product){ create :product, shop_id: Product.shop_ids[:amazon] }
      let(:products){ Product.amazon }

      it { expect(products.count).to eq 1 }
      it { expect(products.first.product_id).to eq product.product_id }
    end
  end

  describe 'product_id_for_url' do
    it 'amazon' do
      product = create :product, shop_id: Product.shop_ids[:amazon]
      expect(product.product_id_for_url).to eq product.product_id.sub('az', '')
    end
  end
end

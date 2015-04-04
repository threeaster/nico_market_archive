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
end

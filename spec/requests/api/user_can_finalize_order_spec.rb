RSpec.describe Api::OrdersController, type: :request do
  let(:product_1) { create(:product, name: "Pizza", price: 120) }
  let(:product_2) { create(:product, name: "Falafel", price: 95) }
  let(:order) { create(:order) }

  before do
    order.order_items.create(product: product_1)
    order.order_items.create(product: product_2)
    put "/api/orders/#{order.id}", params: { activity: "finalize" }
  end

  describe 'PUT /api/orders' do
    it 'responds with a successful message' do
      expect(JSON.parse(response.body)['message']).to eq 'Your order will be ready in 30 minutes'
    end

    it 'sets the order attribute to finalized' do
      expect(order.reload.finalized).to be true
    end
  end
end

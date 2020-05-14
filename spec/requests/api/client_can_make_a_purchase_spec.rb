RSpec.describe Api::OrdersController, type: :request do
  let(:product_1) { create(:product, price: 50) }
  let(:order) { create(:order) }
  let!(:order_item) { create(:order_item, product: product_1, order: order) }

  before do
    put "/api/orders/#{order.id}",
      params: { activity: "finalize", stripeToken: StripeMock.create_test_helper.generate_card_token, email: "testing@test.com" }
  end

  it "user can pay for the order" do
    expect(JSON.parse(response.body)).to eq JSON.parse('{"paid": true, "message": "Your order will be ready in 30 minutes"}')
  end
end

RSpec.describe Api::OrdersController, type: :request do
  let!(:product_1) { create(:product, name: "Pizza", price: 120) }
  let!(:product_2) { create(:product, name: "Pasta", price: 190) }

  before do
    post "/api/orders", params: { product_id: product_1.id }
    order_id = JSON.parse(response.body)["order"]["id"]
    @order = Order.find(order_id)
  end

  describe "POST /api/orders" do
    it "responds with a success message" do
      expect(JSON.parse(response.body)["message"]).to eq "The product has been added to your order"
    end

    it "responds with order id" do
      expect(JSON.parse(response.body)["order"]["id"]).to eq @order.id
    end

    it "responds with correct number of products" do
      expect(JSON.parse(response.body)["order"]["products"].count).to eq 1
    end

    it "responds with order total amount" do
      expect(JSON.parse(response.body)["order"]["total"]).to eq 120
    end
  end

  describe "PUT /api/orders/:id" do
    before do
      put "/api/orders/#{@order.id}", params: { product_id: product_2.id }
      put "/api/orders/#{@order.id}", params: { product_id: product_2.id }
    end

    it "adds another product to order" do
      expect(@order.order_items.count).to eq 3
    end

    it "responds with order id" do
      expect(JSON.parse(response.body)["order"]["id"]).to eq @order.id
    end

    # it "responds with order id" do
    #   expect(JSON.parse(response.body)["order_id"]).to eq @order.id
    # end

    it "responds with order total amount" do
      binding.pry
      expect(JSON.parse(response.body)["order"]["total"]).to eq 500
      
    end
  end
end

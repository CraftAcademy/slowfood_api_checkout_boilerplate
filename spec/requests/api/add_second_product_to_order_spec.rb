# frozen_string_literal: true

RSpec.describe 'PUT /api/orders/:id', type: :request do
  let!(:registered_user) { create(:user) }
  let!(:authorization_headers) { registered_user.create_new_auth_token }
  let!(:existing_order) { create(:order, user: registered_user) }
  let!(:product_already_in_order) { create(:product) }
  let!(:product_to_add) { create(:product, name: 'Pizza') }

  describe 'with valid data' do
    before do
      existing_order.items.create(product: product_already_in_order)
      put "/api/orders/#{existing_order.id}",
          params: { product_id: product_to_add.id },
          headers: authorization_headers
    end

    it {
      expect(response).to have_http_status 201
    }

    it 'is expected to have product data in "items" ' do
      expect(JSON.parse(response.body)['order']['items'][1]['name'])
        .to eq 'Pizza'
    end
  end
end

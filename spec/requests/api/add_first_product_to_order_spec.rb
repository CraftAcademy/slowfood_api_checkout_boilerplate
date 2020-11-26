# frozen_string_literal: true

RSpec.describe 'POST /api/orders', type: :request do
  let!(:product_to_add_to_order) { create(:product) }
  let!(:another_product) {create(:product, name: "Don't like this one")}
  let!(:registered_user) { create(:user) }
  let!(:authorization_headers) { registered_user.create_new_auth_token }

  describe 'with a valid product id' do

    before do
      post '/api/orders',
        params: { product_id: product_to_add_to_order.id},
        headers: authorization_headers
    end

    it {
      expect(response).to have_http_status 201
    }
    # it 'is expected to...' do

    # end
  end
end
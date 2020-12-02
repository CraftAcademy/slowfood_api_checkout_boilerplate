RSpec.describe 'POST /api/subscriptions', type: :request do
  describe 'successfully' do
    let!(:user) { create(:user) }
    let!(:user_headers) { user.create_new_auth_token }

    before do
      post '/api/subscriptions',
           params: {
             stripeToken: StripeMock.create_test_helper.generate_card_token
           },
           headers: user_headers
    end

    it 'is expected to return 200 reponse' do
      expect(response).to have_http_status 200
    end

    it 'is expected to return a success message' do
      expect(JSON.parse(response.body)['message']).to eq 'Thank you for your money, you are now a subscriber!'
    end

    it 'is exptected to turn user into subscriber' do
      expect(user.reload.subscriber).to eq true
    end
  end
end

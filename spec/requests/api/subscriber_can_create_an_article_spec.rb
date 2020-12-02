# frozen_string_literal: true

RSpec.describe 'POST /api/articles/ ', type: :request do
  let!(:registered_user) { create(:user) }
  let!(:user_headers) { registered_user.create_new_auth_token }
  let!(:subscriber) { create(:user, subscriber: true, email: 'subscriber@mail.com') }
  let!(:subscriber_headers) { subscriber.create_new_auth_token }

  describe 'Subscriber can create an article' do
    before do
      post '/api/articles',
           params: { 
             article: 
              { 
                title: 'This is an article', 
                content: 'This is some awesome content' 
                } 
              },
           headers: subscriber_headers
    end

    it 'is expected to return 201 status' do
      expect(response).to have_http_status 201
    end

    it 'expected to return a success message' do
      expect(JSON.parse(response.body)['message']).to eq 'Your article was successfully created'
    end
  end

  describe 'Registrered user can not create an article' do
    before do
      post '/api/articles',
           params: { 
             article: 
              { 
                title: 'This is an article', 
                content: 'This is some awesome content' 
                } 
              },
           headers: user_headers
    end

    it 'is expected to return 401 status' do
      expect(response).to have_http_status 401
    end

    it 'expected to return a success message' do
      expect(JSON.parse(response.body)['message']).to eq 'You are not authorized to do this'
    end
  end
end

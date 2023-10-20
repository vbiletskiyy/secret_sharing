require 'rails_helper'

RSpec.describe 'Secrets API', type: :request do
  let(:user) { create(:user) }
  let(:secret) { create(:secret, user: user) }

  describe 'POST /api/v1/secrets' do
    it 'creates a new secret with valid attributes' do
      secret_attributes = attributes_for(:secret)
      post '/api/v1/secrets', params: { secret: secret_attributes }, headers: authenticate_token

      expect(response).to have_http_status(:ok)
      expect(Secret.count).to eq(1)
    end

    it 'returns an error for invalid secret attributes' do
      invalid_secret_attributes = { content: nil, password: nil, expires_at: nil }
      post '/api/v1/secrets', params: { secret: invalid_secret_attributes }, headers: authenticate_token

      expect(response).to have_http_status(:unprocessable_entity)
      expect(Secret.count).to eq(0)
    end
  end
end

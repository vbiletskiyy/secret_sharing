require 'rails_helper'

RSpec.describe 'Secrets API', type: :request do
  let(:user) { create(:user) }
  let(:secret) { create(:secret, user: user) }

  describe 'GET /api/v1/secrets/:url' do
    context 'with valid password' do
      it 'returns the secret' do
        get "/api/v1/secrets/#{secret.url}", params: { password: secret.password_digest }, headers: authenticate_token
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(secret.content)
      end
    end

    context 'with invalid password' do
      it 'returns an error' do
        get "/api/v1/secrets/#{secret.url}", params: { password: 'incorrect_password' }, headers: authenticate_token
        expect(response).to have_http_status(:forbidden)
        expect(JSON.parse(response.body)['error']).to eq('Invalid password or secret has expired.')
      end
    end

    context 'with an expired secret' do
      it 'returns an error' do
        secret.update(expires_at: Date.yesterday)
        get "/api/v1/secrets/#{secret.url}", params: { password: secret.password_digest }, headers: authenticate_token
        expect(response).to have_http_status(:forbidden)
        expect(JSON.parse(response.body)['error']).to eq('Invalid password or secret has expired.')
      end
    end
  end
end

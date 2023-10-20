require 'rails_helper'

RSpec.describe 'Secrets API', type: :request do
  let(:user) { create(:user) }
  let(:secret) { create(:secret, user: user) }

  describe 'DELETE /api/v1/secrets/:id' do
    it 'deletes an existing secret' do
      delete "/api/v1/secrets/#{secret.url}", headers: authenticate_token(user)

      expect(response).to have_http_status(:no_content)
      expect(Secret.count).to eq(0)
    end

    it 'returns an error when trying to delete a non-existent secret' do
      delete '/api/v1/secrets/999', headers: authenticate_token

      expect(response).to have_http_status(:not_found)
    end
  end
end

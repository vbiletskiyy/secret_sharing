require 'rails_helper'

RSpec.describe 'Secrets API', type: :request do
  let(:user) { create(:user) }
  let(:secret) { create(:secret, user: user) }

  describe 'PUT /api/v1/secrets/:url' do
    it 'edits and updates an existing secret' do
      new_content = 'Updated content'
      put "/api/v1/secrets/#{secret.url}?password=#{secret.password_digest}",
      params: {
        secret: {
          content: new_content,
        }
      },
      headers: authenticate_token(user)

      expect(response).to have_http_status(:ok)
      secret.reload
      expect(secret.content).to eq(new_content)
    end

    it 'returns an error when trying to update with invalid attributes' do
      invalid_content = ''

      put "/api/v1/secrets/#{secret.url}", params: { secret: { content: invalid_content } }, headers: authenticate_token(user)

      expect(response).to have_http_status(:unprocessable_entity)
      secret.reload
      expect(secret.content).not_to eq(invalid_content)
    end
  end
end

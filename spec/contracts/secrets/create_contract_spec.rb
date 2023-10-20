require 'rails_helper'

RSpec.describe Secrets::CreateContract do
  subject(:contract) { described_class.new }

  let(:valid_secret_params) {
    {
      content: FFaker::Lorem.sentence,
      password: 'securepassword',
      url: SecureRandom.uuid,
      expires_at: Date.tomorrow
    }
  }

  it 'is valid with valid attributes' do
    result = contract.call(valid_secret_params)
    expect(result).to be_success
  end

  it 'is not valid without content' do
    invalid_secret_params = valid_secret_params.merge(content: nil)
    result = contract.call(invalid_secret_params)
    expect(result).to be_failure
    expect(result.errors.to_h).to include(content: ['must be filled'])
  end

  it 'is not valid with a short password' do
    invalid_secret_params = valid_secret_params.merge(password: 'short')
    result = contract.call(invalid_secret_params)
    expect(result).to be_failure
    expect(result.errors.to_h).to include(password: ['size cannot be less than 8'])
  end

  it 'is not valid with an expires_at date in the past' do
    invalid_secret_params = valid_secret_params.merge(expires_at: Date.yesterday)
    result = contract.call(invalid_secret_params)
    expect(result).to be_failure
    expect(result.errors.to_h).to include(expires_at: ['must be in the future'])
  end
end

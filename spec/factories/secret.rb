FactoryBot.define do
  factory :secret do
    content { FFaker::Lorem.sentence }
    password { 'securepassword' }
    url { SecureRandom.uuid }
    expires_at { FFaker::Time.between(DateTime.now, DateTime.now + 30) }  # Expires between now and 30 days from now
    association :user
  end
end

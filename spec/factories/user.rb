FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    name { FFaker::Name.name }
    password_digest { BCrypt::Password.create('securepassword') }
  end
end

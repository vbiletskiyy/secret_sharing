class User < ApplicationRecord
  has_secure_password

  has_many :secrets, dependent: :destroy
end

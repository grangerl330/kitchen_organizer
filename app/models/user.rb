class User < ActiveRecord::Base
  has_many :cabinets
  has_many :items
  has_secure_password
end

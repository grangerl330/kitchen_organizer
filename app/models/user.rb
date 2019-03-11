class User < ActiveRecord::Base
  has_many :cabinets
  has_secure_password
end

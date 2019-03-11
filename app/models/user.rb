class User < ActiveRecord::Base
  has_many :cabinets
  has_many :items
  has_secure_password

  def slug
    username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    User.all.find {|user| slug == user.slug}
  end
end

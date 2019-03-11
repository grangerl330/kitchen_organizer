class Item < ActiveRecord::Base
  belongs_to :cabinet
  belongs_to :user
end

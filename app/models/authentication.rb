class Authentication < ApplicationRecord
  has_one :users
  has_one :user_types, :through => :users
  validates :username, uniqueness: true
 
end

class User < ApplicationRecord
  has_one :user_types
  belongs_to :authentication
end

class User < ApplicationRecord
  belongs_to :user_types
  belongs_to :authentication
end

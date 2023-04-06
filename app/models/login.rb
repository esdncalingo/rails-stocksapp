class Login < ApplicationRecord
  belongs_to :user

  def self.time_in(user_id)
    create(
      user_id: user_id,
      login_time: Time.current.utc.to_datetime
    )
  end

  def self.time_out(user_id)
    user = where(user_id: user_id).last
    user.update(
      logout_time: Time.current.utc.to_datetime
    )
  end

end

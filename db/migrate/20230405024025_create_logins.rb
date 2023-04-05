class CreateLogins < ActiveRecord::Migration[7.0]
  def change
    create_table :logins do |t|
      t.integer :user_id
      t.date :login_time
      t.date :logout_time
    end
  end
end

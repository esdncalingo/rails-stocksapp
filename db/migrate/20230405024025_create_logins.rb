class CreateLogins < ActiveRecord::Migration[7.0]
  def change
    create_table :logins do |t|
      t.integer :user_id
      t.datetime :login_time
      t.datetime :logout_time
    end
  end
end

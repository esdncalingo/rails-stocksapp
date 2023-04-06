class CreateAuthentications < ActiveRecord::Migration[7.0]
  def change
    create_table :authentications do |t|
      t.integer :user_id
      t.string :username
      t.string :password
      t.string :token
      t.boolean :is_active
    end
  end
end

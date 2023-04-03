class CreateAuthentications < ActiveRecord::Migration[7.0]
  def change
    create_table :authentications do |t|
      t.string :username
      t.string :password
      t.string :token

      t.timestamps
    end
  end
end

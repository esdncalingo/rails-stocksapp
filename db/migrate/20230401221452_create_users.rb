class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :password
      t.string :fname
      t.string :mname
      t.string :lname
      t.integer :user_typeid
      t.string :token

      t.timestamps
    end
  end
end

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :fname
      t.string :mname
      t.string :lname
      t.string :contacts
      t.string :address
      t.float :wallet
      t.string :status

      t.timestamps
    end
  end
end

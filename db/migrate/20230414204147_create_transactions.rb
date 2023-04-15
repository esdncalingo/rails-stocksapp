class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.integer :qty, :default => 0
      t.float :price, :default => 0
      t.float :amount, :default => 0
      t.string :transaction_type
      t.string :stock_code, :default => ""
      t.string :crypto_code, :default => ""
      t.timestamps 
    end
  end
end

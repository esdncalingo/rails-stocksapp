class CreateAccTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :acc_types do |t|
      t.string :type

      t.timestamps
    end
  end
end

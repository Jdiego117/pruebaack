class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :branch
      t.string :code
      t.string :start_preparation
      t.string :delivery_time
      t.references :client, foreign_key: true
      t.string :delivery_method
      t.boolean :cash_payment
      t.float :subtotal
      t.float :taxes
      t.float :total
      t.string :status

      t.timestamps
    end
  end
end

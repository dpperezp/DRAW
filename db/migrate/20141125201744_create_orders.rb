class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :address
      t.string :pay_type

      t.timestamps
    end
  end
end

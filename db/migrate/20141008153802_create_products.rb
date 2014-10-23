class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.string :image, limit: 1000 # :length => 1000
      t.text :description

      t.timestamps
    end
  end
end

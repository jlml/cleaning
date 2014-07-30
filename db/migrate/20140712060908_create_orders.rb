class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :location
      t.string :cleaner
      t.date :cleandate
      t.time :cleantime
      t.integer :rooms
      t.integer :bathroom
      t.float :cleanduration
      t.float :price
      t.integer :number
      t.string :email
      t.string :name
      t.string :message

      t.timestamps
    end
  end
end

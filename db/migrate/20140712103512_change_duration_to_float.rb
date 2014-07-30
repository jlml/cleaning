class ChangeDurationToFloat < ActiveRecord::Migration
  def change
  	remove_column :orders, :cleanduration
  	add_column :orders, :cleanduration, :float
  end
end

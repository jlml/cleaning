class ChangeDurationToFloat < ActiveRecord::Migration
  def change
  	change_column :orders, :cleanduration, :float 
  end
end

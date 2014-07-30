class ChangeDurationToFloat < ActiveRecord::Migration
  def change
  	change_column :orders, :cleanduration, 'float USING CAST(cleanduration AS float)'
  end
end

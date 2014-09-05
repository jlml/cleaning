class CreateCleaners < ActiveRecord::Migration
  def change
    create_table :cleaners do |t|
      t.string :name

      t.timestamps
    end
  end
end

class CreateTimings < ActiveRecord::Migration
  def change
    create_table :timings do |t|
      t.datetime :available_at

      t.references :service

      t.timestamps
    end
  end
end

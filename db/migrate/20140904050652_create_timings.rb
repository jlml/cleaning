class CreateTimings < ActiveRecord::Migration
  def change
    create_table :timings do |t|
      t.datetime :available_date
      t.datetime :available_from
      t.datetime :available_till

      t.references :service

      t.timestamps
    end
  end
end

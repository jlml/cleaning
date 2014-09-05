class AddCleanerIdToServices < ActiveRecord::Migration
  def change
    add_column :services, :cleaner_id, :integer
  end
end

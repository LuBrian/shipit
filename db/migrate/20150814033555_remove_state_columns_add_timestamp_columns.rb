class RemoveStateColumnsAddTimestampColumns < ActiveRecord::Migration
  def change
    remove_column :packages, :ready_for_pickup 
    remove_column :packages, :accepted
    remove_column :packages, :delivered
    remove_column :packages, :picked_up
    add_column :packages, :assigned_time, :datetime
    add_column :packages, :pick_up_time, :datetime
    add_column :packages, :delivery_time, :datetime
  end
end

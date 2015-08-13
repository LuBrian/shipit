class AddPackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :title
      t.string :origin
      t.string :destination
      t.integer :length
      t.integer :width
      t.integer :height
      t.text :notes
      t.boolean :accepted
      t.boolean :ready_for_pickup
      t.boolean :picked_up
      t.boolean :delivered
      t.integer :customer_id
      t.integer :driver_id
  end
end
end 

class DistanceForPackage < ActiveRecord::Migration
  def change
  	add_column :packages, :distance, :float
  end
end

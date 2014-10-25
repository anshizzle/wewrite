class AddDefaultToLine < ActiveRecord::Migration
  def change
  	change_column :lines, :score, :integer, :default => 0
  	change_column :lines, :depth, :integer, :default => 0
  end
end

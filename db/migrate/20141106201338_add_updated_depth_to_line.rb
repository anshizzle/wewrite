class AddUpdatedDepthToLine < ActiveRecord::Migration
  def change
  	add_column :lines, :updated_depth, :datetime


  	Line.all.each do |line| 
  		line.update_attribute(:updated_depth, line.story.lines.last.created_at)
  	end

  end
end

class AddFirstLineIdToStory < ActiveRecord::Migration
  def change
  	add_column :stories, :first_line_id, :integer

  	Story.all.each do |story|
  		story.update_attribute(:first_line_id, story.first_line_deprecated.id)
  	end

  end
end

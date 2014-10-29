class CreateStories < ActiveRecord::Migration
  def up
    create_table :stories do |t|
      t.timestamps
    end

    add_column :lines, :story_id, :integer

    create_table :collaborators_stories, id: false do |t|
    	t.timestamps
    	t.belongs_to :collaborator
    	t.belongs_to :story
    end

    Line.first_lines.each do |line|
    	story = Story.create
    	line.update_attribute(:story_id, story.id)
    	story.collaborators << line.user unless line.user.nil?

    	lines_to_visit = line.next_lines.to_ary
    	while not lines_to_visit.empty? 
    		next_line = lines_to_visit.pop
    		lines_to_visit.concat(next_line.next_lines)
    		next_line.story = story
    		next_line.save
    		story.collaborators << next_line.user unless next_line.user.nil?
    	end
    end

  end

  def down
  	drop_table :stories
  	remove_column :lines, :story_id
  	drop_table :collaborators_stories

  end
end

class Story < ActiveRecord::Base
	
	has_many :lines
	has_and_belongs_to_many :collaborators, :class_name => "User", :join_table => "collaborators_stories", :association_foreign_key => :collaborator_id

end

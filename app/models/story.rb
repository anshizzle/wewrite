# == Schema Information
#
# Table name: stories
#
#  id            :integer          not null, primary key
#  created_at    :datetime
#  updated_at    :datetime
#  first_line_id :integer
#

class Story < ActiveRecord::Base

	scope :created_at_desc, -> { order("created_at desc") }
	
	has_many :lines
	has_and_belongs_to_many :collaborators, :class_name => "User", :join_table => "collaborators_stories", :association_foreign_key => :collaborator_id

	
	def first_line_deprecated
		self.lines.first_lines.first
	end

	def first_line
		self.first_line_id.nil? ? self.first_line_deprecated : Line.find(self.first_line_id)
	end
end

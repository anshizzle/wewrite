# == Schema Information
#
# Table name: lines
#
#  id               :integer          not null, primary key
#  text             :string(255)
#  score            :integer          default(0)
#  depth            :integer          default(0)
#  previous_line_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#  story_id         :integer
#  user_id          :integer
#

class Line < ActiveRecord::Base

	scope :first_lines, -> { where previous_line_id: nil}
	scope :ranked, -> { order("score + depth DESC")}

	belongs_to :user
	belongs_to :story
	belongs_to :previous_line, :class_name => "Line", :foreign_key => "previous_line_id"
	has_many :next_lines, :class_name => "Line", :foreign_key => "previous_line_id"
	validates_presence_of :text

	after_create :update_depths


	def update_depths
		line = self.previous_line
		while !line.nil?
			line.update_attribute(:depth, line.depth + 1)
			line = line.previous_line
		end
	end

	def first_line
		line = self
		while !line.previous_line.nil?
			line = line.previous_line
		end
		line
	end

	def collect_lines
		line = self
		lines = [self]
		while !line.previous_line.nil?
			lines.unshift(line.previous_line)
			line = line.previous_line
		end
		lines
	end

	def tree_data(parent)
		data = "{"
		data = data + "\"name\": \"#{self.text}\", \"parent\": \""
		parent.nil? ? data = data + "null" : data = data + parent.text
		data = data  + "\""

		unless self.next_lines.empty?
			data = data + ", \"children\": ["

			self.next_lines.ranked.each do |line| 
				data = data + line.tree_data(self)

				data = data + ", " if line != self.next_lines.last
			end
			data = data + "]"
		end  
		data = data + "}"
	end

end


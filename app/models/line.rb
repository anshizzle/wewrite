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
#  user_id          :integer
#  story_id         :integer
#  updated_depth    :datetime
#

class Line < ActiveRecord::Base

	scope :first_lines, -> { where previous_line_id: nil}
	scope :ranked, -> { order("score + depth DESC")}
	scope :created_at_desc, -> { order("created_at DESC") }

	belongs_to :user
	belongs_to :story
	belongs_to :previous_line, :class_name => "Line", :foreign_key => "previous_line_id"
	has_many :next_lines, :class_name => "Line", :foreign_key => "previous_line_id"
	validates_presence_of :text

	after_create :update_depths

	def self.find_orphan_ids
		Line.where([
		  "user_id NOT IN (?) OR story_id NOT IN (?)",
		  User.pluck("id"),
		  Story.pluck("id")
		]).destroy_all 
	end


	def total_score
		# 1/time_since_last_added_to * score + depth


		time = Time.now - self.updated_depth
		return 500/time * self.score + self.depth 
	end

	def update_depths
		line = self.previous_line
		self.update_attribute(:updated_depth, Time.now)
		while !line.nil?
			line.update_attribute(:depth, line.depth + 1)
			line.update_attribute(:updated_depth, Time.now)
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
			data = data + "\"name\": \"#{self.sanitized_text[/(\s*\S+){#{3}}/]}...\", \"parent\": \""
			parent.nil? ? data = data + "null" : data = data + parent.sanitized_text[/(\s*\S+){#{3}}/] + "..."
			data = data  + "\""

			unless self.next_lines.empty?
				data = data + ", \n\"children\": ["

				lines = self.next_lines.ranked

				lines.each do |line| 
					data = data + line.tree_data(self)

					data = data + ", " unless line == lines.last
				end


				data = data + "]"
			end  
			data = data + "}\n"

	end

	def sanitized_text
		new_text = self.text.gsub(/'/, { "'" => "\\'"} )
		new_text = new_text.gsub("\n", "")
		new_text = new_text.gsub("\r", "")
		new_text = new_text.gsub("\"", "\\\"")
		new_text
	end


end


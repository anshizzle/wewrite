# == Schema Information
#
# Table name: lines
#
#  id               :integer          not null, primary key
#  text             :string(255)
#  score            :integer
#  depth            :integer
#  previous_line_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Line < ActiveRecord::Base
	belongs_to :previous_line, :class_name => "Line", :foreign_key => "previous_line_id"
	validates_pr
end

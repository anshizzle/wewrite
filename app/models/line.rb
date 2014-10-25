# == Schema Information
#
# Table name: lines
#
#  id            :integer          not null, primary key
#  text          :string(255)
#  score         :integer
#  depth         :integer
#  previous_line :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Line < ActiveRecord::Base
end

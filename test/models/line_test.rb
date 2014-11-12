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

require 'test_helper'

class LineTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

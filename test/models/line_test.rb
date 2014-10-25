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

require 'test_helper'

class LineTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

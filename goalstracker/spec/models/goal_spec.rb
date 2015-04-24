# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  title      :string
#  user_id    :integer
#  type       :string
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Goal, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

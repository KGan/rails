# == Schema Information
#
# Table name: votes
#
#  id           :integer          not null, primary key
#  value        :integer          default("0"), not null
#  user_id      :integer          not null
#  votable_id   :integer          not null
#  votable_type :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true

  def v=(v)
    self.value = (v <=> 0)
  end
end

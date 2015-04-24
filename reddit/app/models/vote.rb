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
  validates_uniqueness_of :votable_id, scope:[:votable_type, :user_id]
  belongs_to :user
  belongs_to :votable, polymorphic: true


  def val=(val)
    self.value = (Integer(val) <=> 0)
  end

  def self.already_voted?(vote)
    exists?(:votable_id => vote.votable_id, :user_id => vote.user_id, :votable_type => vote.votable_type, id: 1..Float::INFINITY)
  end

  def self.null_vote(vote)
    find_by(:votable_id => vote.votable_id, :user_id => vote.user_id, :votable_type => vote.votable_type).destroy
  end
end

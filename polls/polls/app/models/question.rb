# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  question   :text
#  poll_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  validates :question, presence: true
  validates :poll_id, presence: true

  belongs_to :poll
  has_many :answer_choices

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

  def results
    answers_with_counts = answer_choices.select('answer_choices.*, COUNT(*) as num_responses')
    .joins('LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id')
    .group('answer_choices.id')

    answers_hash = {}
    answers_with_counts.each { |answer| answers_hash[answer.choice] = answer.num_responses }
    answers_hash.sort
  end

end

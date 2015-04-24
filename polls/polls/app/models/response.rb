# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  responder_id     :integer
#  answer_choice_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base
  validates :responder_id, presence: true
  validates :answer_choice_id, :uniqueness => { scope: :responder_id}, presence: true
  validate :respondent_has_not_already_answered_question
  validate :poll_creator_cannot_answer_own_poll

  belongs_to :answer_choice
  belongs_to(
    :respondent,
    class_name: 'User',
    foreign_key: :responder_id,
    primary_key: :id
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )

  def sibling_responses
    question.responses.where('responses.id is NOT NULL AND responses.id != ?', id)


      # filter out ourself

    # a = Response.
    #    .joins(:question)
    #    .joins(:answer_choice)
    #    .where(answer_choices: {id: answer_choice_id})
    # # a.joins(answer_choice: :responses)
    # #   .select('responses.*')
    # #   .where('responses.id is NOT NULL AND responses.id != ?', id)
    # #   .distinct

  end

  def poll
    question.poll
  end

  private
  def respondent_has_not_already_answered_question
    if sibling_responses.exists?(:responder_id => responder_id)
      errors[:already_answered] << "Respondent has already answered"
    end
  end

  def poll_creator_cannot_answer_own_poll
    if Poll.joins(questions: :answer_choices)
           .where(answer_choices: {id: answer_choice_id}, author_id: responder_id)
           .exists?
      errors[:creator_response] << "Creator cannot answer own poll"
    end
  end


end

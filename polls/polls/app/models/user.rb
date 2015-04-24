# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates :user_name, uniqueness: true, presence: true

  has_many(
    :polls,
    class_name: 'Poll',
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: 'Response',
    foreign_key: :responder_id,
    primary_key: :id
  )

  def completed_polls
    Poll.find_by_sql([<<-SQL, id])
      SELECT
        polls.*
      FROM
        polls
      JOIN
        questions ON polls.id = questions.poll_id
      JOIN
        (SELECT
          answer_choices.*, COUNT(*) r_qs
        FROM
          responses
        JOIN
          answer_choices ON answer_choices.id = responses.answer_choice_id
        WHERE
          responses.responder_id = ?
        GROUP BY
          answer_choices.id
          ) AS user_responses
        ON user_responses.question_id = questions.id
      GROUP BY
        polls.id, user_responses.r_qs 
      HAVING
        user_responses.r_qs = COUNT(questions.id)
    SQL

  end
end

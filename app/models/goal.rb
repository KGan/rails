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

class Goal < ActiveRecord::Base
  include Commentable
  
  STATUSES = %w(INCOMPLETE INPROGRESS COMPLETE)
  TYPES = %w(PUBLIC PRIVATE)
  before_validation :default_status
  validates_presence_of :title
  validates :status, inclusion: {in: STATUSES}
  validates :goaltype, inclusion: {in: TYPES}

  belongs_to :user, inverse_of: :goals

  private
    def default_status
      self.status ||= 'INCOMPLETE'
    end
end

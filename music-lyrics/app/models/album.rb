# == Schema Information
#
# Table name: albums
#
#  id             :integer          not null, primary key
#  band_id        :integer
#  title          :string
#  recording_type :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer          not null
#

class Album < ActiveRecord::Base
  RECORD_TYPES = %w(studio live)
  validates_presence_of :title, :recording_type, :band_id
  validates :recording_type, inclusion: {in: RECORD_TYPES}
  belongs_to :band
  belongs_to :user
  has_many :tracks, dependent: :destroy

  def name
    self.title
  end
end

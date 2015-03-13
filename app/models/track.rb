# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  album_id   :integer
#  title      :string
#  track_type :string
#  lyrics     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#

class Track < ActiveRecord::Base
  TRACK_TYPES = %w(regular bonus)
  validates_presence_of :album_id, :title, :track_type
  validates :track_type, inclusion: {in: TRACK_TYPES}
  belongs_to :album
  has_one :band, through: :album
  belongs_to :user

  def name
    self.title
  end
end

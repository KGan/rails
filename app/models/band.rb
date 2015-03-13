# == Schema Information
#
# Table name: bands
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#

class Band < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :albums, dependent: :destroy

end

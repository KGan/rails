# == Schema Information
#
# Table name: sessions
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  session_token :string           not null
#  location      :string
#  user_agent    :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Session < ActiveRecord::Base
  validates_presence_of :user_id, :session_token
  validates_uniqueness_of :session_token
  belongs_to :user
  after_initialize :set_token


  private
    def set_token
      self.session_token ||= SecureRandom.urlsafe_base64
    end
end

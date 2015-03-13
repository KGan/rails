# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  include BCrypt
  validates_presence_of :email, :password_digest
  validates_uniqueness_of :email
  has_many :sessions

  def self.find_session(session_token)
    Session.find_by(:session_token => session_token).try(:user)
  end

  def self.find_by_credentials(email, password)
    u = find_by(email: email)
    if u.is_password?(password)
      return u
    end
    nil
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

end

# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  validates_presence_of :email, :password_digest, :session_token
  validates_uniqueness_of :session_token, :email
  after_initialize :ensure_session_token

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(email, password)
    user = self.find_by(email: email)
    if user && user.is_password?(password)
      return user
    end
    nil
  end

  def self.generate_session_token
    begin
      token = SecureRandom.urlsafe_base64
    end until !User.exists?(:session_token => token)
    token
  end

  def reset_session_token!
    self.update(session_token: User.generate_session_token)
    self.session_token
  end

  def admin?
    self.admin
  end
  private
    def ensure_session_token
      self.session_token ||= SecureRandom.urlsafe_base64
    end
end

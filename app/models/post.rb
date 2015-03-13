# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates_presence_of :title, :user
  belongs_to :user
  has_many :post_subs, inverse_of: :post, dependent: :destroy
  has_many :posted_subs, through: :post_subs, source: :sub
  has_many :comments, as: :commentable
end

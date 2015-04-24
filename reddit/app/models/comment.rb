# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :text             not null
#  commentable_id   :integer          not null
#  commentable_type :string           not null
#  user_id          :integer          not null
#  post_id          :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Comment < ActiveRecord::Base
  include Votable
  validates_presence_of :content, :commentable, :user, :post
  belongs_to :user
  belongs_to :post
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
end

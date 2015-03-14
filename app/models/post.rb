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
  include Votable
  validates_presence_of :title, :user
  belongs_to :user
  has_many :post_subs, inverse_of: :post, dependent: :destroy
  has_many :posted_subs, through: :post_subs, source: :sub
  has_many :comments, as: :commentable
  has_many :all_comments, class_name: 'Comment',
                          foreign_key: :post_id,
                          primary_key: :id

  
  def comments_hash
    children = Hash.new(Array.new)
    all_comments.each do |comment|
      puts "Commentable type: #{comment.commentable_type}"
      puts "Commentable id: #{comment.commentable_id}"
      puts "class : #{comment.class.name}"
      if comment.commentable_type == comment.class.name && comment.commentable_id
        children[comment.commentable_id] += [comment]
      end
    end
    children
  end
end

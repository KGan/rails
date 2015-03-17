class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true

  validates_presence_of :body

  def url_for
    url = commentable_type.downcase
    url += '_url'
    Rails.application.routes.url_helpers.send(url.to_sym, commentable)
  end
end

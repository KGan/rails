module Votable
  extend ActiveSupport::Concern
  included do
    has_many :votes, as: :votable
  end

  def upvotes
    self.votes.where(:value => 1).count
  end

  def downvotes
    self.votes.where(:value => -1).count
  end

  def vote_url
    trail = self.class.name.downcase
    trail = "vote_" + trail + "_url"
    Rails.application.routes.url_helpers.send trail.to_sym, self.id
  end
end
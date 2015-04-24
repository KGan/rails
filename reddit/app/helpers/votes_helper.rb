module VotesHelper
  def votes(votable)
    return unless votable.class.ancestors.include?(Votable)
    (<<-HTML).html_safe
      <div class="media-left">
        <p class="upvotes">#{votable.upvotes}</p> <hr style="border-color:black"> <p class="downvotes">#{votable.downvotes}</p>
      </div>
    HTML
  end
end

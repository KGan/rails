class VotesController < ApplicationController
  def create
    @vote = Vote.new(vote_params)
    if @vote.class.already_voted?(@vote)
      @vote.class.null_vote(@vote)
    elsif @vote.save
    else
      flash[:errors] = @vote.errors.full_messages
    end
    redirect_to :back
  end

  private
    def vote_params
      params.require(:vote).permit(:val, :votable_id, :votable_type).merge({user_id: current_user.id})
    end
end

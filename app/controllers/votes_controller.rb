class VotesController < ApplicationController
  def create
    @vote = Vote.new(vote_params)
    if @vote.save
      redirect_to :back
    else
      flash[:errors] = @vote.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
  end

  private
    def vote_params
      params.require(:vote).permit(:v, :votable_id, :votable_type).merge({user_id: current_user.id})
    end
end

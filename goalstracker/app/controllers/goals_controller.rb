class GoalsController < ApplicationController
  before_action :require_login
  def index
    # puts params[:user_id]
    @user = User.find(params[:user_id])
    @goals = Goal.where(user_id: params[:user_id])
    unless @user == current_user
      @goals = @goals.where(goaltype: 'PUBLIC')
    end

  end

  def show
    @goal = Goal.find(params[:id])
    # @comments = @goal.comments
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)

    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash[:errors] = @goal.errors.full_messages
      redirect_to :back
    end
  end

  def update
    @goal = Goal.find(params[:id])

    if @goal && @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash[:errors] = @goal.errors.full_messages
      redirect_to :back
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
  end

  private
    def goal_params
      params.require(:goal).permit(:title, :status, :goaltype).merge({user_id: current_user.id})
    end
end

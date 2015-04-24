class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
      redirect_to user_goals_url(current_user)
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user
      @user.destroy
    else
      flash[:errors] = 'no user to delete'
    end
    redirect_to :back
  end

  private
    def user_params
      params.require(:user).permit(:username, :password)
    end
end

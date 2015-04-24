class BandsController < ApplicationController
  before_action :is_owner?, only: [:update, :edit, :destroy]
  def index
    @bands = Band.all
    render :index
  end

  def new
    render :new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to band_url(@band)
    else
      flash[:errors] = @band.errors.full_messages
      redirect_to root_url
    end
  end

  def show
    @band = Band.find(params[:id])
    render :show
  end

  def edit
    @band = Band.find(params[:id])
    render :edit
  end

  def update
    @band = Band.find(params[:id])
    if @band.update(band_params)
      redirect_to band_url(@band)
    else
      flash[:errors] = @band.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    @band = Band.find(params[:id])
    if @band
      @band.destroy
      redirect_to bands_url
    else
      flash[:errors] = "Band not Found"
      redirect_to :back
    end
  end
  private
    def band_params
      params.require(:band).permit(:name).merge({user_id: current_user.id})
    end
    def is_owner?
      if Band.find(params[:id]).try(:user).try(:id) != current_user.id
        flash[:errors] = "Could not authorize this action"
        redirect_to :back
      end
    end
end

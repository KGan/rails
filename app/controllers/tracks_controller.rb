class TracksController < ApplicationController
  before_action :is_owner?, only: [:edit, :update, :destroy]
  def index
    @tracks = Track.all
    render :index
  end

  def new
    @album = Album.find(params[:album_id])
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track)
    else
      flash[:errors] = @track.errors.full_messages
      redirect_to :back
    end

  end

  def show
    @track = Track.find(params[:id])
    if @track
      @heirarchy = [@track.album, @track.band]
      render :show
    else
      redirect_to albums_url
    end
  end

  def edit
    @track = Track.find(params[:id])
    @heirarchy = [@track.album, @track.band]
  end

  def update
    @track = Track.find(params[:id])
    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      flash[:errors] = @track.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    @track = Track.find(params[:id])
    if @track
      @track.destroy
      redirect_to :back
    else
      flash[:errors] = "no track"
      redirect_to :back
    end
  end

  private
    def track_params
      params.require(:track).permit(:album_id, :title, :track_type, :lyrics).merge({user_id: current_user.id})
    end
    def is_owner?
      if Track.find(params[:id]).try(:user).try(:id) != current_user.id
        flash[:errors] = "Could not authorize this action"
        redirect_to :back
      end
    end
end

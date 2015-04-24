class AlbumsController < ApplicationController
  before_action :is_owner?, only: [:update, :edit, :destroy]
  def index
    @albums = Album.all
    if @albums
      render :index
    else
      flash[:errors] = "No Albums"
      redirect_to bands_url
    end
  end

  def new
    @band = Band.find(params[:band_id])
    if @band
      render :new
    else
      flash[:errors] = "couldn't find band #{params[:id]}"
      redirect_to bands_url
    end
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def show
    @album = Album.find(params[:id])
    @heirarchy = [@album.band]
  end

  def edit
    @album = Album.find(params[:id])
    @heirarchy = [@album.band]
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      flash[:errors] = @album.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    @album = Album.find(params[:id])
    if @album
      @album.destroy
      redirect_to :back
    else
      flash[:errors] = "Could not find album"
      redirect_to :back
    end
  end
  private
    def album_params
      params.require(:album).permit(:band_id, :title, :recording_type).merge({user_id: current_user.id})
    end
    def is_owner?
      if Album.find(params[:id]).try(:user).try(:id) != current_user.id
        flash[:errors] = "Could not authorize this action"
        redirect_to :back
      end
    end
end

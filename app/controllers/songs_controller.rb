class SongsController < ApplicationController
  before_action :set_song, only: [:destroy, :publish]

  def create
    @song = Song.new(song_params)
    @song.uploader = current_user
    @song.save
  end

  def destroy
    authorize @song
    @song.destroy
    head :ok
  end

  def publish
    @song.update(publish_params)
    head :ok
  end

  private

  def set_song
    @song = Song.find(params[:id])
  end

  def song_params
    params.require(:song).permit(:attachment)
  end

  def publish_params
    params.permit(:is_active)
  end

  def verify_authorized
    authorize :base, :access?
  end
end

class SongsController < ApplicationController
  def create
    @song = Song.new(song_params)
    @song.uploader = current_user
    @song.save
    head :ok
  end

  private

  def song_params
    params.require(:song).permit(:attachment)
  end

  def verify_authorized
    authorize :base, :access?
  end
end

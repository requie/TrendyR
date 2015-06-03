module Base
  module Resources
    class SongsController < Resources::BaseController
      before_action :set_song, only: [:destroy, :publish]

      def create
        @song = Song.new(song_params) do |song|
          song.uploader = current_user
        end
        @song.save!
      end

      def destroy
        authorize @song
        @song.destroy
        render nothing: true
      end

      def publish
        @song.update(publish_params)
        render nothing: true
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
    end
  end
end

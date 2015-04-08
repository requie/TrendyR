class ArtistGigDecorator < ApplicationDecorator
  delegate_all

  def profile
    artist.profile.decorate
  end
end

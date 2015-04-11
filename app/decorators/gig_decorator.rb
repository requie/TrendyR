class GigDecorator < ApplicationDecorator
  delegate_all
  decorates_associations :artist_gigs, :artists

  def pending_requests
    model.artist_gigs.with_status(:pending).decorate
  end
end

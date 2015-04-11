class ArtistGigDecorator < ApplicationDecorator
  delegate_all

  decorates_association :profile
end

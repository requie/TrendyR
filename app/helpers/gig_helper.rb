module GigHelper
  def gig_apply_block(gig)
    content_tag(:div, class: 'applied') do
      if user_signed_in? && current_user.role?(:artist)
        artist_block(gig, Booking.exists?(gig_id: gig, artist_id: current_user.entity))
      else
        default_artist_block(gig)
      end
    end
  end

  private

  def default_artist_block(gig)
    if gig.artists.any?
      concat content_tag(:p, 'Artists')
      gig.artists.first(4).each do |artist|
        concat image_tag(mini_url(artist.profile))
      end
    end
  end

  def artist_block(gig, applied = false)
    if gig.artists.any?
      concat content_tag(:p, applied ? 'Already applied' : 'Artists')
      gig.artists.first(4).each do |artist|
        concat image_tag(mini_url(artist.profile))
      end
    elsif !applied
      concat content_tag(:p, 'Be the first', class: 'text-center')
      concat content_tag(:p, 'Apply this gig now!', class: 'text-center')
    end
    unless applied
     #content = link_to("$#{gig.price.round} Apply now", request_base_profile_booking_path(gig), class: 'btn btn-primary request')
      content = link_to("$#{format("%.2f", gig.price)} Apply now", gig, class: 'btn btn-primary request')
      concat content_tag(:div, content, class: 'button-poster')
    end
  end
end

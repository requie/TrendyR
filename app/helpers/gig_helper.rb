module GigHelper
  def gig_apply_block(gig)
    is_artist = current_user.role?(:artist)
    is_applied = is_artist && gig.artists.include?(current_user.entity)
    content_tag(:div, class: 'applied') do
      concat content_tag(:p, 'Already applied') if is_applied
      if gig.artists.any?
        concat content_tag(:p, 'Artists') unless is_applied
        gig.artists.first(4).each do |artist|
          concat image_tag(mini_url(artist.profile))
        end
      else
        concat content_tag(:p, 'Be the first', class: 'text-center')
        concat content_tag(:p, 'Apply this gig now!', class: 'text-center')
      end
      concat content_tag(
        :div,
        link_to(
          "$#{gig.price.round} Apply now",
          'javascript: void(0)',
          class: 'btn btn-primary',
          disabled: (!is_artist || is_applied)
        ),
        class: 'button-poster'
      )
    end
  end
end

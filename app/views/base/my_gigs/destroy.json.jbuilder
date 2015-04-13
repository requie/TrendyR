json.array!(@gigs) do |gig|
  json.call gig, :id, :title, :price
  json.photo gig.photo.with_presets([:cropped, :medium])
  json.period period(gig)
  json.address get_address(gig.location)
  json.status status(gig)
  json.requests(gig.artist_gigs.with_status(:pending)) do |request|
    json.call request, :id, :profile_id
    json.avatar avatar_url(request.profile)
    json.link_to_approve set_request_status_base_profile_gig_path(@profile, request, status: 'confirmed')
    json.link_to_cancel set_request_status_base_profile_gig_path(@profile, request, status: 'rejected')
  end
end

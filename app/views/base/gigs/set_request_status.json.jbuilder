json.array!(@artist_gigs) do |artist_gig|
  json.id artist_gig.id
  json.profile_id artist_gig.profile.id
  json.avatar artist_gig.profile.avatar_url
end

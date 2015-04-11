json.array!(@gigs) do |gig|
  json.call gig, :id, :title, :price
  json.photo gig.photo.with_presets([:cropped, :medium])
  json.period period(gig)
  json.location get_address(gig.location)
  json.status status(gig)
end

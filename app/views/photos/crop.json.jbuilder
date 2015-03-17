if @photo.valid?
  json.data do
    json.photo @photo
    json.url @photo_url
    json.profile_id @photo.uploader.profile.id
  end
else
  json.errors @photo.errors.values.flatten
end

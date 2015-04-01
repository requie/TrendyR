if @photo.valid?
  json.photo do
    json.id @photo.id
    json.url @photo.cropped
    json.profile_id @photo.uploader.profile.id
  end
else
  json.errors @photo.errors.values.flatten
end

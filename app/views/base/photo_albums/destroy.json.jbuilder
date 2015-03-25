if @photo_albums
  json.array!(@photo_albums) do |photo_album|
    json.id photo_album.id
    json.title photo_album.title
    json.first_photo photo_album.first_photo.large
    json.remaining_photos photo_album.remaining_photos
    json.date_of_creation photo_album.date_of_creation
    json.number_of_photos photo_album.number_of_photos
  end
else
  json.errors @photo.errors.values.flatten
end

json.array!(@photo_albums) do |photo_album|
  json.call photo_album, :id, :title, :remaining_photos, :date_of_creation, :number_of_photos
  json.first_photo photo_album.first_photo.with_preset(:large)
end

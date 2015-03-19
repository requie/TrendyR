if @photo.valid?
  json.photo do
    json.id @photo.id
    json.url @photo.url
    json.width @photo.attachment.width
    json.height @photo.attachment.height
  end
else
  json.errors @photo.errors.values.flatten
end

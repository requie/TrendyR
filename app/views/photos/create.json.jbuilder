if @photo.valid?
  json.data do
    json.photo @photo
    json.url Dragonfly.app.remote_url_for(@photo.attachment_uid)
    json.photo_width @photo.attachment.width
    json.photo_height @photo.attachment.height
  end
else
  json.errors @photo.errors.values.flatten
end

if @photo.valid?
  json.data do
    json.photo @photo
    json.url Dragonfly.app.remote_url_for(@photo.attachment_uid)
  end
else
  json.errors @photo.errors.values.flatten
end

if @photo.valid?
  json.data do
    json.photo @photo
  end
else
  json.errors @photo.errors.values.flatten
end

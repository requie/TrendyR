json.array!(@events) do |event|
  json.call event, :id, :title, :price
  json.photo event.photo.with_presets([:cropped, :medium])
  json.period period(event)
  json.location get_address(event.location)
  json.status status(event)
end

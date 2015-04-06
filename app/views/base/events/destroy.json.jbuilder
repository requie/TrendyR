if @events
  json.array!(@events) do |event|
    json.id event.id
    json.title event.title
    json.photo event.photo.with_presets([:cropped, :medium])
    json.period period(event)
    json.location get_address(event.location)
    json.price event.price
  end
else
  json.errors @photo.errors.values.flatten
end
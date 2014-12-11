module Photoable
  extend ActiveSupport::Concern

  # use this module by calling in models
  #   extend Photoable
  #
  # then for example call this method
  #
  #   bind_photo_accessors :photo, :wallpaper
  #
  # to create methods like
  #
  #   #photo_url and #wallpaper_url
  #
  # they will use defined model relations, so if your model does not have 'photo' or 'wallpaper' relation
  # method creation will fail
  def bind_photo_accessors(*relation_names)
    relation_names.each do |relation_name|
      define_method("#{relation_name}_url") do |preset_name|
        photo = send(relation_name)
        return unless photo.present? && photo.attachment_stored?
        preset = photo.presets[preset_name]
        fail "Unknown preset for '#{relation_name.capitalize}' - '#{preset_name}'" if preset.nil?
        photo.thumb(preset).url
      end
    end
  end
end

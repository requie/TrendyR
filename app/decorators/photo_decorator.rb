class PhotoDecorator < ApplicationDecorator
  delegate_all

  def url
    Dragonfly.app.remote_url_for(object.attachment_uid)
  end
end

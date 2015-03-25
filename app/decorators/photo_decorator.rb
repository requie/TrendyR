class PhotoDecorator < ApplicationDecorator
  delegate_all

  def url
    Dragonfly.app.remote_url_for(model.attachment_uid)
  end

end

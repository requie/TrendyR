class PhotoDecorator < ApplicationDecorator
  delegate_all

  def url
    Dragonfly.app.remote_url_for(model.attachment_uid)
  end

  def small
    thumb('175x131#')
  end

  def medium
    thumb('355x256#')
  end
end

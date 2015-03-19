class PhotoDecorator < ApplicationDecorator
  delegate_all

  def url
    Dragonfly.app.remote_url_for(model.attachment_uid)
  end

  def private_gallery_size
    thumb("175x131#")
  end

  def gallery_size
    thumb("355x256#")
  end
end

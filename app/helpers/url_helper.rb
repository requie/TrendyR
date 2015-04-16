module UrlHelper
  def url_with_protocol(url)
    return '' if url.blank?
    URI(url).scheme.blank? ? "http://#{url}" : url
  end
end

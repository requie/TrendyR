module ApplicationHelper
  # Set title for current page/layout
  def title(title)
    content_for(:title) { title }
  end

  # Include stylesheets from templates, which will be yielded into layout by :stylesheet key
  def stylesheet(file)
    content_for(:stylesheet) { stylesheet_link_tag(file, media: 'all') }
  end

  # Include javascripts from templates, which will be yielded into layout by :javascript key
  def javascript(*files)
    content_for(:javascript) { javascript_include_tag(*files) }
  end
end

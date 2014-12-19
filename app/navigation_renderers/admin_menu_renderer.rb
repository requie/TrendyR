class AdminMenuRenderer < SimpleNavigation::Renderer::List
  def render(item_container)
    return '' if skip_if_empty? && item_container.empty?
    content = list_content(item_container)
    content_tag(:ul, content, item_container.dom_attributes)
  end

  private

  def list_content(item_container)
    item_container.items.map do |item|
      li_options = item.html_options.except(:link)
      li_content = tag_for(item)
      if include_sub_navigation?(item)
        sub_content = item.sub_navigation.items.collect do |sub_item|
          sub_li_options = sub_item.html_options.except(:link)
          sub_li_content = tag_for(sub_item)
          content_tag(:li, sub_li_content, sub_li_options)
        end.join
        li_content << content_tag(:ul, sub_content, class: 'nav nav-second-level')
      end
      content_tag(:li, li_content, li_options)
    end.join
  end
end

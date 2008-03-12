module ApplicationHelper
  # Dynamically showing all flashes
  def flashes
    flash.map {|type, content| content_tag(:div, content, :class => "flash", :id => "flash_#{type}")}
  end
  
  # Make HTML lists out of arrays.
  def list(items)
    content_tag(:ul, items.map{|item| content_tag(:li, yield(item))})
  end
end

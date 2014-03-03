module ApplicationHelper
  def user_with_image(user)
    content_tag :div, { :class => "user-with-image" } do
      style = "background-image: url('" + user.image_url + "')"
      content_tag(:span, "", :class => "image", :style => style) + user.name
    end
  end
end

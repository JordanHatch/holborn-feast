module ApplicationHelper
  def user_with_image(user)
    content_tag :div, { :class => "user-with-image" } do
      user_image = ""
      if user.image_url.present?
        style = "background-image: url('" + user.image_url + "')"
        user_image = content_tag(:span, "", :class => "image", :style => style)
      end

      user_image + user.name
    end
  end
end

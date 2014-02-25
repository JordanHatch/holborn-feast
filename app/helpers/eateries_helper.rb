module EateriesHelper

  def recommendation_icon(user)
    style = "background-image: url('" + user.image_url + "')"
    content_tag :li, { style: style, title: user.name } do
      user.name
    end
  end
end

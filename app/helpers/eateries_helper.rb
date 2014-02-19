module EateriesHelper

  def recommendation_icon(name, email)
    style = "background-image: url('" + gravatar_url(email, :size => 64).html_safe + "')"
    content_tag :li, { style: style } do
      name
    end
  end
end

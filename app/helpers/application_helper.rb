module ApplicationHelper
  def app_logo
    content_tag(:span, "Lunch", class: ["first-letter", "logo-text"]) + content_tag(:span, "Meet", class: ["second-letter", "logo-text"])
  end

  def app_logo_in_white
    content_tag(:span, "Lunch", class: ["first-letter", "logo-text", "text-white"]) + content_tag(:span, "Meet", class: ["second-letter", "logo-text", "text-white"])
  end

  def yelp_img_ls url
    url.split('/').map {|v| (v.split('.').size == 2 && v.split('.').last == 'jpg') ? 'ls.jpg' : v }.join('/')
  end
end

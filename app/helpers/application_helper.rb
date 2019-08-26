module ApplicationHelper
  def app_logo
    content_tag(:span, "Lunch", class: ["first-letter", "logo-text"]) + content_tag(:span, "Meet", class: ["second-letter", "logo-text"])
  end
end

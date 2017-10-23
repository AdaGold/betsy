module ApplicationHelper

  def pretty_date(date)
    ("<span class='date'>" + date.strftime('%a, %d %b %Y') + "</span>").html_safe
  end

end

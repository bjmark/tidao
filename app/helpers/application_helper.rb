module ApplicationHelper
  def h2(title)
    raw(%Q|<h2 style="display:inline;color:#E36627">#{title}</h2>|)
  end
end

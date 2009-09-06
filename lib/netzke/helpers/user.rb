module Netzke::Helpers::User
  def active_recently
    bulb = active_recently? ? "on" : "off"
    "<div class='bulb-#{bulb}' />"
  end
end
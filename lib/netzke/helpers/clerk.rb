module Netzke::Helpers::Clerk
  # Returns html that shows a on/off bulb
  def updated_bulb
    bulb = updated ? "on" : "off"
    "<div class='bulb-#{bulb}' />"
  end
end
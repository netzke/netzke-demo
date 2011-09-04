# Extend GridPanel to be specific about the model and columns we want to display
class ClerkGrid < Netzke::Basepack::GridPanel
  # Include CSS for displaying the light bulb (see the source code)
  css_include :main

  def configuration
    super.merge({
      :model => "Clerk",
      :persistence => true,

      # Declaring columns
      :columns => [
        {
          :name => :name,
          :renderer => "uppercase",
          :width => 200
        },
        :first_name,
        :last_name,
        {
          :name => :updated_bulb,
          :width => 40,
          :label => "<div class='bulb-off' />",
          :tooltip => "Recently updated",
          :getter => lambda { |r|
            bulb = r.updated ? "on" : "off"
            "<div class='bulb-#{bulb}' />"
          }
        },
        :email,
        {
          :name => :boss__last_name,
          :scope => ["salary >= ?", 95000],
          :header => "Boss"
        },
        {:name => :image, :getter => lambda{ |r| "<a href='#{r.image.url}'>Download</a>" if r.image.url }}
      ]
    })
  end
end
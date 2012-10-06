# Extend GridPanel to be specific about the model and columns we want to display
class ClerkGrid < Netzke::Basepack::GridPanel
  css_configure do |c|
    # include CSS for displaying the light bulb (see the source code)
    c.include :main
  end

  def configure(c)
    c.model = "Clerk"
    c.persistence = true

    # Declaring columns
    c.columns = [
      {
        :name => :name,
        :renderer => "uppercase",
        :width => 200
      },
      :first_name,
      :last_name,
      {
        :name => :updated_bulb,
        :width => 30,
        :header => "",
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
    super
  end
end

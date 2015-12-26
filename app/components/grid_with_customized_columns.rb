# Extend Grid to be specific about the model and columns we want to display
class GridWithCustomizedColumns < Netzke::Grid::Base
  client_styles do |c|
    # include CSS for displaying the light bulb (see `components/clerks/client/main.css`)
    c.require :main
  end

  attribute :recently_updated do |c|
    # Do not show this virtual attribute in the form
    c.field_config = { excluded: true }
  end

  def configure(c)
    c.model = Employee

    c.columns = [
      {
        name: :name,
        renderer: :uppercase,
        width: 300
      },
      { name: :email, width: 250 },
      { name: :salary, renderer: :us_money },
      { name: :department__name, flex: 1 },
      {
        name: :recently_updated,
        width: 80,
        header: "Updated",
        tooltip: "Recently updated",
        getter: lambda { |r|
          bulb = r.updated_at > 1.hour.ago ? "on" : "off"
          "<div class='bulb-#{bulb}' />"
        },
        sorting_scope: lambda { |r, dir| r.order(updated_at: dir) }
      },
    ]
    super
  end
end

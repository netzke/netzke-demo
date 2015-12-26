class GridWithCustomFormLayout < Netzke::Grid::Base
  def configure(c)
    super

    c.model = "Clerk"

    c.form_items = [
      {
        layout: :hbox, border: false, anchor: "100%",
        defaults: {layout: 'anchor'},
        items: [
          {
            flex: 1, border: false,
            defaults: {anchor: "-25", label_width: 80},
            items: [ :name ]
          },
          {
            flex: 1, border: false,
            defaults: {anchor: "100%", label_width: 50},
            items: [ :email, :salary ]
          }
        ]
      },
      { name: :boss__name, anchor: "100%", label_width: 80 }
    ]
  end

  # Hide "image" column from grid
  attribute :image do |c|
    c.excluded = true
  end
end

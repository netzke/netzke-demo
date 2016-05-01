class GridWithCustomFormLayout < Netzke::Grid::Base
  def configure(c)
    super

    c.model = Employee

    c.form_items = [
      {
        layout: :hbox, border: false, anchor: "100%",
        defaults: {layout: 'anchor', flex: 1, border: false},
        items: [
          {
            defaults: {anchor: "-25", label_width: 80},
            items: [ :name, :birthdate ]
          },
          {
            defaults: {anchor: "100%", label_width: 50},
            items: [ :email, :salary ]
          }
        ]
      },
      { name: :department__name, anchor: "100%", label_width: 80 }
    ]
  end

  # Hide "image" column from grid
  attribute :image do |c|
    c.excluded = true
  end
end

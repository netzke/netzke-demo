class WindowWithGridPanel < Netzke::Basepack::Window
  def configure(c)
    super
    c.persistence = true
    c.title = "Window nesting a grid"
    c.width = 800
    c.height = 400
    c.items = [{component: :bosses, header: false}]
  end

  component :bosses
end

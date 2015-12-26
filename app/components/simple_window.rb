class SimpleWindow < Netzke::Window::Base
  def configure(c)
    super
    c.width = 400
    c.height = 300
    c.title = "Simple window"
    c.persistence = true
    c.maximizable = true
  end
end

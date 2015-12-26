class GridWithDefaults < Netzke::Grid::Base
  def configure(c)
    super
    c.model = Employee
  end
end

class GridWithDefaults < Netzke::Grid::Base
  def configure(c)
    super
    c.model = Clerk
  end
end

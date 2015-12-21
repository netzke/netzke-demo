class GridWithPersistentColumns < Netzke::Grid::Base
  def configure(c)
    super
    c.model = "Boss"
    c.persistence = true
  end
end

class Bosses < Netzke::Grid::Base
  def configure(c)
    super
    c.model = "Boss"
  end
end

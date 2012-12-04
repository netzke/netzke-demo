class GridWithPersistentColumns < Netzke::Basepack::Grid
  def configure(c)
    super
    c.model = "Boss"
    c.persistence = true
  end
end

class Bosses < Netzke::Basepack::Grid
  def configure(c)
    super
    c.model = "Boss"
  end

  include PgGridTweaks
end

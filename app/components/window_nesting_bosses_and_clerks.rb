class WindowNestingBossesAndClerks < Netzke::Basepack::Window
  def configure(c)
    super
    c.persistence = true
    c.title = "Window nesting a compound component"
    c.width = 800
    c.height = 500
    c.items = [:bosses_and_clerks]
  end

  component :bosses_and_clerks
end

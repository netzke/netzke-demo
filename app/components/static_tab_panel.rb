class StaticTabPanel < Netzke::Basepack::TabPanel
  component :clerks do |c|
    c.eager_loading = true
  end

  component :bosses do |c|
    c.eager_loading = true
  end

  def configure(c)
    c.active_tab = 0
    c.prevent_header = true
    c.items = [ { :title => "I'm just a simple Ext.Panel" }, :clerks, :bosses ]
    super
  end
end

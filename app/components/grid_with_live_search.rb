class GridWithLiveSearch < Clerks
  plugin :grid_live_search do |c|
    c.klass = Netzke::Basepack::GridLiveSearch
  end

  def configure(c)
    super
    c.tbar = [ {xtype: 'textfield', attr: :name, empty_text: 'search by name'} ]
    c.paging = true
  end
end

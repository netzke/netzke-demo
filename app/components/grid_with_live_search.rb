class GridWithLiveSearch < Clerks
  plugin :grid_live_search do |c|
    c.klass = Netzke::Basepack::GridLiveSearch
  end

  def configure(c)
    super
    c.tbar = [ {xtype: 'textfield', attr: :name, empty_text: 'search by name'} ]
    c.paging = true
  end

  attribute :name do |c|
    c.filter_with = lambda {|rel, value, op| rel.where("clerks.first_name ilike ? or clerks.last_name ilike ?", "%#{value}%", "%#{value}%")}
  end
end

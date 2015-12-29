class GridWithCustomAction < Netzke::Grid::Base
  def model
    Employee
  end

  def bbar
    [*super, "-", :count_records]
  end

  action :count_records do |c|
    c.text = "Record count"
    c.icon = :information
  end

  endpoint :count_records do
    client.set_title("Total records: #{model.count}")
  end

  # Client-side methods declared inline for conciseness
  client_class do |c|
    c.netzke_on_count_records = l(<<-JS)
      function(){
        this.server.countRecords();
      }
    JS
  end
end

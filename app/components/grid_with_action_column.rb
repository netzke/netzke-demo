class GridWithActionColumn < Netzke::Grid::Base
  include Netzke::Basepack::ActionColumn

  client_class do |c|
    c.force_fit = true
    # handler for the 'delete' column action
    c.netzke_on_delete_row = <<-JS
      function(grid, rowIndex, colIndex){
        this.getSelectionModel().select(rowIndex);
        this.netzkeOnDelete();
      }
    JS
  end

  column :actions do |c|
    c.type = :action
    c.actions = [{name: :delete_row, icon: :delete}]
    c.header = ""
    c.width = 20
  end

  def configure(c)
    super
    c.model = "Clerk"
    c.columns = [:first_name, :last_name, :email, :actions]
  end
end

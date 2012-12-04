class GridWithActionColumn < Netzke::Basepack::Grid
  include Netzke::Communitypack::ActionColumn

  js_configure do |c|
    c.force_fit = true
    # handler for the 'delete' column action
    c.on_delete_row = <<-JS
      function(record){
        this.getSelectionModel().select(record);
        this.onDel();
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

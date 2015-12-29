class CustomActionGrid < Netzke::Grid::Base
  action :show_details do |c|
    c.text = "Show details"
    c.disabled = true
  end

  def model
    Clerk
  end

  def bbar
    [*super, "-", :show_details]
  end

  def context_menu
    [*super, "-", :show_details]
  end

  # Client-side methods declared inline for conciseness
  client_class do |c|
    c.init_component = l(<<-JS)
      function(){
        this.callParent();

        this.getSelectionModel().on('selectionchange', function(selModel){
          this.actions.showDetails.setDisabled(selModel.getCount() != 1);
        }, this);
      }
    JS

    c.netzke_on_show_details = l(<<-JS)
      function(){
        var tmpl = new Ext.Template("<b>{0}</b>: {1}<br/>"), html = "",
            record = this.getSelectionModel().getSelection()[0];

        Ext.iterate(record.data, function(key, value){
          if (key != '_meta') html += tmpl.apply([key.humanize(), value]);
        }, this);

        Ext.Msg.show({
          title: "Details",
          width: 400,
          msg: html
        });
      }
    JS
  end
end

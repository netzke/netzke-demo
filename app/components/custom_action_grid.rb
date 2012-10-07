class CustomActionGrid < Netzke::Basepack::GridPanel
  action :show_details do |c|
    c.text = "Show details"
    c.disabled = true
  end

  def configure(c)
    c.model = "Clerk" # For stand-alone testing

    super

    c.bbar = [:show_details, "-", *c.bbar]
    c.context_menu = [:show_details, "-", *c.context_menu]
  end

  js_configure do |c|
    c.init_component = <<-JS
      function(){
        this.callParent();

        this.getSelectionModel().on('selectionchange', function(selModel){
          this.actions.showDetails.setDisabled(selModel.getCount() != 1);
        }, this);
      }
    JS

    c.on_show_details = <<-JS
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

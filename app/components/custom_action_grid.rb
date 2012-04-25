class CustomActionGrid < Netzke::Basepack::GridPanel
  add_source_code_tool

  action :show_details do |c|
    c.text = "Show details"
    c.disabled = true
  end

  # For stand-alone testing
  model "Clerk"

  # overriding 2 GridPanel's methods
  def default_bbar
    [:show_details, "-", *super]
  end

  def default_context_menu
    [:show_details, "-", *super]
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();

      this.getSelectionModel().on('selectionchange', function(selModel){
        this.actions.showDetails.setDisabled(selModel.getCount() != 1);
      }, this);
    }
  JS

  js_method :on_show_details, <<-JS
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

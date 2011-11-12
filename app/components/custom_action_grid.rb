class CustomActionGrid < Netzke::Basepack::GridPanel
  action :show_details, :text => "Show details", :disabled => true

  # For stand-alone testing
  model "Clerk"

  # Add 2 Ext tools that open source code and tutorial links for this component
  add_source_code_tool
  add_tutorial_tool :link => "http://writelesscode.com"

  # overriding 2 GridPanel's methods
  def default_bbar
    [:show_details.action, "-", *super]
  end

  def default_context_menu
    [:show_details.action, "-", *super]
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

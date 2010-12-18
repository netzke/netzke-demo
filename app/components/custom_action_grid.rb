class CustomActionGrid < Netzke::Basepack::GridPanel
  action :show_details, :text => "Show details", :disabled => true

  def default_config
    super.merge(:model => "Clerk")
  end

  # overriding 2 GridPanel's methods
  def default_bbar
    [:show_details.action, "-", *super]
  end

  def default_context_menu
    [:show_details.action, "-", *super]
  end

  js_method :init_component, <<-JS
    function(){
      #{js_full_class_name}.superclass.initComponent.call(this);

      this.getSelectionModel().on('selectionchange', function(selModel){
        this.actions.showDetails.setDisabled(selModel.getCount() != 1);
      }, this);
    }
  JS

  js_method :on_show_details, <<-JS
    function(){
      var tmpl = new Ext.Template("<b>{0}</b>: {1}<br/>"), html = "";
      Ext.iterate(this.getSelectionModel().getSelected().data, function(key, value){
        html += tmpl.apply([key.humanize(), value]);
      }, this);


      Ext.Msg.show({
        title: "Details",
        width: 300,
        msg: html
      });
    }
  JS
end

module Netzke
  class CustomActionGrid < GridPanel
    def actions
      super.merge({
        :show_details => {:text => "Show details", :disabled => true}
      })
    end
    
    def default_bbar
      ["show_details", "-", *super]
    end
    
    def default_context_menu
      ["show_details", "-", *super]
    end
    
    def self.js_extend_properties
      {
        :init_component => <<-END_OF_JAVASCRIPT.l,
          function(){
            #{js_full_class_name}.superclass.initComponent.call(this);
            
            this.getSelectionModel().on('selectionchange', function(selModel){
              this.actions.showDetails.setDisabled(selModel.getCount() != 1);
            }, this);
          }
        END_OF_JAVASCRIPT
        
        :on_show_details => <<-END_OF_JAVASCRIPT.l,
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
        END_OF_JAVASCRIPT
      }
    end
  end
end
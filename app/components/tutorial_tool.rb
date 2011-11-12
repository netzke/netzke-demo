# This is a plugin that displays a tool by clicking which the user navigates to the tutorial of the corresponding component
# Requires the :link option to be set
class TutorialTool < Netzke::Base
  js_base_class "Ext.Component"

  js_method :init, <<-JS
    function(cmp){
      this.parent = cmp;

      if (!cmp.tools) cmp.tools = [];

      cmp.tools.push({type: 'help', handler: this.onGear, tooltip: "Tutorial", scope: this});
    }
  JS

  js_method :on_gear, <<-JS
    function(){
      console.info("this.link: ", this.link);
    }
  JS
end

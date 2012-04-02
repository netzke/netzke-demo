# This is a plugin that displays a tool by clicking which the user navigates to the source code of the corresponding component
class SourceCodeTool < Netzke::Base
  js_base_class "Ext.Component"

  def configuration
    super
    config.link = [NetzkeDemo::Application.config.repo_root, c[:file].sub(Rails.root.to_s, "")].join
  end

  js_method :init, <<-JS
    function(cmp){
      this.parent = cmp;

      if (!cmp.tools) cmp.tools = [];

      cmp.tools.push({type: 'right', handler: this.onSourceCode, tooltip: "Source code", scope: this});
    }
  JS

  js_method :on_source_code, <<-JS
    function(){
      console.info("this.link: ", this.link);
    }
  JS
end

# This is a plugin that displays a tool by clicking which the user navigates to the source code of the corresponding component
class SourceCodeTool < Netzke::Plugin

  def configure(c)
    super
    c.link = [NetzkeDemo::Application.config.repo_root, config.file.sub(Rails.root.to_s, "")].join
  end

  js_configure do |c|
    c.init = <<-JS
      function(cmp){
        this.callParent(arguments);
        if (!cmp.tools) cmp.tools = [];
        cmp.tools.push({type: 'help', handler: this.onSourceCode, tooltip: "Source code", scope: this});
      }
    JS

    c.on_source_code = <<-JS
      function(){
        console.info("this.link: ", this.link);
      }
    JS
  end

end

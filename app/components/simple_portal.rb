class SimplePortal < Netzke::Base
  js_base_class "Ext.app.PortalPanel"

  js_mixin

  portal_path = Netzke::Core.ext_path.join("examples/portal")

  # js_include(portal_path.join("classes.js")) # Bad, bad, keep off! Component not in session???

  js_include(portal_path.join("classes/PortalColumn.js"))
  js_include(portal_path.join("classes/PortalDropZone.js"))
  js_include(portal_path.join("classes/PortalPanel.js"))

  css_include(portal_path.join("portal.css"))

  action :one_column_layout
  action :reset_layout

  action :add_server_stats_widget

  js_property :tbar, [:add_server_stats_widget.action, "-", :reset_layout.action]
  js_property :prevent_header, false

  js_property :component_layout, "dock"

  title "My Portal"

  # Initial portlets
  items [{
    items: [
      {:class_name => "Portlet::CpuChart"}
    ]
  }, {
    items: [
      {:class_name => "Portlet::ClerkForm"}
    ]
  }, {
    items: [
      {:class_name => "Portlet::ServerStats"},
    {
      title: "Portlet 3,1",
      height: 200,
      # items: [{class_name: "ClerkGrid"}]
    }]
  }]

  def configuration
    super.tap do |c|
      # Uncomment to enable storing in session
      # c[:items] = component_session[:portlets] ||= c[:items]
    end
  end

  endpoint :server_update_layout do |params|
    component_session[:portlets] = params[:layout]
    {}
  end

  js_method :on_one_column_layout, <<-JS
    function(){
      this.serverUpdateLayout();
    }
  JS

  js_method :on_reset_layout, <<-JS
    function(){
      this.serverResetLayout();
    }
  JS

  endpoint :server_reset_layout do |params|
    component_session[:portlets] = nil
  end

  component :server_stats_widget, :lazy_loading => true, :prevent_header => true, :auto_update => false, :title => "Server stats"

end
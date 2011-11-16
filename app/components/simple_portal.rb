class SimplePortal < Netzke::Base
  js_base_class "Ext.app.PortalPanel"
  #
  # js_mixin
  #
  portal_path = Netzke::Core.ext_path.join("examples/portal")

  # js_include(portal_path.join("classes.js")) # Bad, bad, keep off! Component not in session???

  js_include(portal_path.join("classes/PortalColumn.js"))
  js_include(portal_path.join("classes/PortalDropZone.js"))
  js_include(portal_path.join("classes/PortalPanel.js"))
  js_include(portal_path.join("classes/Portlet.js"))

  css_include(portal_path.join("portal.css"))

  action :one_column_layout
  action :reset_layout

  js_property :tbar, [:one_column_layout.action, :reset_layout.action]
  js_property :prevent_header, false

  js_property :component_layout, "dock"

  title "My Portal"

  # Initial portlets
  items [{
    items: [{
      title: "Portlet 1,1",
      height: 300,
      # items: [{class_name: "BossDetails"}]
    },{
      title: "Portlet 1,2",
      height: 200,
      # items: [{class_name: "ClerkGrid"}]
    }]
  },{
    items: [{
      title: "Portlet 2,1",
      height: 200,
      # items: [{class_name: "ClerkGrid"}]
    },{
      title: "Portlet 2,2",
      height: 150,
      # items: [{class_name: "ClerkGrid"}]
    }]
  },{
    items: [{
      title: "Portlet 3,1",
      height: 200,
      # items: [{class_name: "ClerkGrid"}]
    },{
      title: "Portlet 3,2",
      height: 150,
      # items: [{class_name: "ClerkGrid"}]
    }]
  }]

  def configuration
    super.tap do |c|
      # ::Rails.logger.debug "!!! Netzke::Core.session: #{Netzke::Core.session.inspect}\n"
      c[:items] = component_session[:portlets] ||= c[:items]
      ::Rails.logger.debug "!!! c[:items]: #{c[:items].inspect}\n"
    end
  end

  endpoint :server_update_layout do |params|
    component_session[:portlets] = params[:layout]
    ::Rails.logger.debug "!!! params[:layout]: #{params[:layout].inspect}\n"
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


  js_method :init_component, <<-JS
    function(){
      this.callParent();

      this.on('drop', function(){
        var portlets = [];
        this.items.each(function(column){
          var columnPortlets = [];
          column.items.each(function(portlet){
            columnPortlets.push({
              // item_id: portlet.id,
              title: portlet.title,
              height: portlet.getHeight()
            });
          });
          portlets.push({items: columnPortlets});
        });

        this.serverUpdateLayout({layout: portlets});
      }, this);
    }
  JS

end
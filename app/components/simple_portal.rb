class SimplePortal < Netzke::Base
  js_base_class "Ext.app.PortalPanel"

  js_mixin

  title "My Portal"

  js_property :tbar, [:add_server_stats_portlet, :add_cpu_chart_portlet, "-", :reset_layout]
  js_property :prevent_header, false

  # Override original Portal setting in order to look like a panel - e.g. have the header, toolbars, etc
  js_property :component_layout, "dock"

  # Portal-related Ext JS javascripts
  portal_path = Netzke::Core.ext_path.join("examples/portal")

  # js_include(portal_path.join("classes.js")) # Bad, bad, keep off! Component not in session???
  js_include(portal_path.join("classes/PortalColumn.js"))
  js_include(portal_path.join("classes/PortalDropZone.js"))
  js_include(portal_path.join("classes/PortalPanel.js"))

  # ... and styles
  css_include(portal_path.join("portal.css"))


  # Actions
  action :one_column_layout
  action :reset_layout
  action :add_server_stats_portlet
  action :add_cpu_chart_portlet

  # Initial portlets.

  def items
    [{
      items: [
        # {:class_name => "Portlet::CpuChart"}
      ]
    }, {
      items: [
        # {:class_name => "Portlet::ClerkForm"}
      ]
    }, {
      items: [
        {:class_name => "Portlet::ServerStats"},
        {
          title: "Portlet 3,1",
          item_id: 'ext_portlet1',
          height: 200
        }
      ]
    }]
  end

  def js_config
    super.tap do |c|
      # we'll store the items in persistence storage
      c[:items] = component_session[:layout] ||= c[:items]
    end
  end

  def components
    # we'll store components in persistence storage
    component_session[:components] ||= super
  end

  endpoint :server_update_layout do |params|
    # we will extend the received layout (containing only item_ids) with full-config hashes
    new_layout = params[:layout]

    # all currently used items
    flatten_items = []
    iterate_items(js_config[:items]){ |item| flatten_items << item }

    # replace hashes in receved layout with full-config hashes from flatten_items
    iterate_items(new_layout) do |current_item|
      # detect full-config by item_id
      full_config_item = flatten_items.detect{ |item| item[:netzke_component].to_s == current_item["item_id"] || item[:item_id] == current_item["item_id"] }

      current_item.merge!(full_config_item)
    end

    # store new layout
    component_session[:layout] = new_layout

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

  # Reset to use initial items
  endpoint :server_reset_layout do |params|
    component_session[:portlets] = nil
    component_session[:components] = nil
    component_session[:layout] = nil
  end

  def deliver_component_endpoint(params)
    cmp_name = params[:name]
    cmp_index = cmp_name.sub("cmp", "").to_i

    # add new component to components hash first
    component_session[:components].merge!(cmp_name.to_sym => {:class_name => "Portlet::#{params[:class_name]}"})

    # add it also into the layout
    component_session[:layout].last[:items] << cmp_name.to_sym.component

    super
  end

  protected

    # iterates through provided items recursively and yields each found hash
    def iterate_items(items_array, &block)
      items_array.each do |item|
        items = item[:items] || item["items"]
        items.is_a?(Array) ? iterate_items(items, &block) : yield(item)
      end
    end

end

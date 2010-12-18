class SimpleApp < Netzke::Base
  js_base_class "Ext.Viewport"

  js_properties(
    :layout => :border
  )

  def configuration
    super.merge(
      :items => [{
        :region => :north,
        :height => 35,
        :html => %Q{
          <div style="margin:10px; color:#333; text-align:center; font-family: Helvetica;">
            <span style="color:#B32D15">Netzke</span> Simple App
          </div>
        },
        :bodyStyle => {"background" => "#FFF url(\"/images/header-deco.gif\") top left repeat-x"}
      },{
        :region => :center,
        :id => "components_container",
        :tbar => [
          {:text => "Simple components", :menu => [
            :bosses.action,
            :clerks.action,
            :custom_action_grid.action
          ]},
          {:text => "Composite components", :menu => [
            :bosses_and_clerks.action
          ]}
        ]

      }]
    )
  end

  js_method :load_component_by_action, <<-JS
    function(a){
      this.loadComponent({name: a.name, container: "components_container"});
    }
  JS

  # Components
  component :clerks, :class_name => "Basepack::GridPanel", :model => "Clerk", :lazy_loading => true
  action :clerks, :handler => :load_component_by_action

  component :bosses, :class_name => "Basepack::GridPanel", :model => "Boss", :lazy_loading => true
  action :bosses, :handler => :load_component_by_action

  component :custom_action_grid, :model => "Boss", :lazy_loading => true
  action :custom_action_grid, :handler => :load_component_by_action

  component :bosses_and_clerks, :lazy_loading => true
  action :bosses_and_clerks, :handler => :load_component_by_action

end

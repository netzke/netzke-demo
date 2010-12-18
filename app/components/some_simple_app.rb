class SomeSimpleApp < Netzke::Basepack::SimpleApp

  def menu
    [
      {:text => "Simple components", :icon => uri_to_icon(:application), :menu => [:clerks.action, :bosses.action, :custom_action_grid.action]},
      {:text => "Composite components", :icon => uri_to_icon(:application_tile_horizontal), :menu => [:bosses_and_clerks.action]}
    ]
  end

  def configuration
    sup = super
    sup.merge(
      :items => [{
        :region => :north,
        :height => 35,
        :html => %Q{
          <div style="margin:10px; color:#333; text-align:center; font-family: Helvetica;">
            Simple <span style="color:#B32D15">Netzke</span> App
          </div>
        },
        :bodyStyle => {:background => %Q(#FFF url("/images/header-deco.gif") top left repeat-x)}
      },{
        :region => :center,
        :layout => :border,
        :items => sup[:items]
      }]
    )
  end

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

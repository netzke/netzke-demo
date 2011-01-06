module Touch
  class SimpleTabPanel < Netzke::Base
    js_base_class "Ext.TabPanel"

    js_properties(
      :fullscreen => true,
      :docked_items => [{:dock => :top, :xtype => :toolbar, :title => 'Netzke Demo: SimpleTabPanel'}]
    )

    def configuration
      super.merge({:items => [:bosses.component, :clerks.component]})
    end

    component :bosses, :class_name => "Touch::SimpleList", :title => "Bosses", :model => "Boss", :item_tpl => "{last_name}, ${salary}"
    component :clerks, :class_name => "Touch::SimpleList", :title => "Clerks", :model => "Clerk", :item_tpl => "{last_name}"
  end
end

class BossesAndClerks < Netzke::Basepack::BorderLayoutPanel
  js_property :header, false

  def configuration
    super.merge(
      :items => [
        {
          :region => :center,
          :title => "Bosses",
          :name => "bosses",
          :class_name => "Basepack::GridPanel",
          :model => "Boss"
        },
        :boss_details.component(
          :region => :east,
          :name => "info",
          :width => 240,
          :split => true
        ),
        :clerks.component(
          :region => :south,
          :title => "Clerks",
          :height => 250,
          :split => true
        )
      ]
    )
  end

  # Overriding initComponent
  js_method :init_component, <<-JS
    function(){
      // calling superclass's initComponent
      #{js_full_class_name}.superclass.initComponent.call(this);

      // setting the 'rowclick' event
      this.getChildComponent("bosses").on('rowclick', function(self, rowIndex){
        // The beauty of using Ext.Direct: calling 3 endpoints in a row, which results in a single call to the server!
        this.selectBoss({boss_id: self.store.getAt(rowIndex).get('id')});
        this.getChildComponent('clerks').getStore().reload();
        this.getChildComponent('boss_details').updateStats();
      }, this);
    }
  JS

  endpoint :select_boss do |params|
    # store selected boss id in the session for this component's instance
    component_session[:selected_boss_id] = params[:boss_id]
  end

  component :clerks do
    {
      :class_name => "Netzke::Basepack::GridPanel",
      :model => "Clerk",
      :load_inline_data => false,
      :scope => {:boss_id => component_session[:selected_boss_id]},
      :strong_default_attrs => {:boss_id => component_session[:selected_boss_id]}
    }
  end

  component :boss_details do
    {
      :class_name => "BossDetails",
      :boss_id => component_session[:selected_boss_id]
    }
  end

end

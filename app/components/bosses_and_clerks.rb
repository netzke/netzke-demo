class BossesAndClerks < Netzke::Basepack::BorderLayoutPanel
  add_source_code_tool

  def configuration
    super.merge(
      :persistence => true,
      :items => [
        :bosses.component(
          :region => :center,
          :title => "Bosses"
        ),
        :boss_details.component(
          :region => :east,
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
      this.callParent();

      // setting the 'rowclick' event
      var view = this.getComponent('bosses').getView();
      view.on('itemclick', function(view, record){
        // The beauty of using Ext.Direct: calling 3 endpoints in a row, which results in a single call to the server!
        this.selectBoss({boss_id: record.get('id')});
        this.getComponent('clerks').getStore().load();
        this.getComponent('boss_details').updateStats();
      }, this);
    }
  JS

  endpoint :select_boss do |params|
    # store selected boss id in the session for this component's instance
    component_session[:selected_boss_id] = params[:boss_id]
  end

  component :bosses do
    {
      :class_name => "Netzke::Basepack::GridPanel",
      :model => "Boss"
    }
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

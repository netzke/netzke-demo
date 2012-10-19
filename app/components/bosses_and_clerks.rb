class BossesAndClerks < Netzke::Base
  # Remember regions collapse state and size
  include Netzke::Basepack::ItemsPersistence

  def configure(c)
    super
    c.items = [
      { netzke_component: :bosses, region: :center },
      { netzke_component: :boss_details, region: :east, width: 240, split: true },
      { netzke_component: :clerks, region: :south, height: 250, split: true }
    ]
  end

  js_configure do |c|
    c.layout = :border
    c.border = false

    # Overriding initComponent
    c.init_component = <<-JS
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
  end

  endpoint :select_boss do |params, this|
    # store selected boss id in the session for this component's instance
    component_session[:selected_boss_id] = params[:boss_id]
  end

  component :bosses do |c|
    c.klass = Netzke::Basepack::GridPanel
    c.model = "Boss"
  end

  component :clerks do |c|
    c.klass = Netzke::Basepack::GridPanel
    c.model = "Clerk"
    c.data_store = {auto_load: false}
    c.scope = {:boss_id => component_session[:selected_boss_id]}
    c.strong_default_attrs = {:boss_id => component_session[:selected_boss_id]}
  end

  component :boss_details do |c|
    c.klass = BossDetails
    c.boss_id = component_session[:selected_boss_id]
  end
end

class BossesAndClerks < Netzke::Base
  # Remember regions collapse state and size
  include Netzke::Basepack::ItemPersistence

  def configure(c)
    super
    c.header = false
    c.items = [
      { component: :bosses, region: :center, border: false },
      { component: :boss_details, region: :east, width: 240, split: true, border: false },
      { component: :clerks, region: :south, height: 250, split: true, border: false }
    ]
  end

  client_class do |c|
    c.layout = :border
    c.border = false

    # Overriding initComponent. We do inline in the Ruby code for the sake of simplicity.
    c.init_component = l(<<-JS)
      function(){
        // calling superclass's initComponent
        this.callParent();

        // setting the 'rowclick' event
        var view = this.getComponent('bosses').getView();
        view.on('itemclick', function(view, record){
          // The beauty of using Ext.Direct: calling 3 endpoints in a row, which results in a single call to the server!
          this.serverConfig.selected_boss_id = record.get('id');
          this.getComponent('clerks').getStore().load();
          this.getComponent('boss_details').updateStats();
        }, this);
      }
    JS
  end

  component :bosses do |c|
    c.klass = Netzke::Grid::Base
    c.model = "Boss"
  end

  component :clerks do |c|
    c.klass = Clerks
    c.data_store = {auto_load: false}
    c.scope = lambda {|rel| rel.where(boss_id: client_config[:selected_boss_id])}
    c.strong_values = {boss_id: client_config[:selected_boss_id]}
  end

  component :boss_details do |c|
    c.klass = BossDetails
    c.boss_id = client_config[:selected_boss_id]
  end
end

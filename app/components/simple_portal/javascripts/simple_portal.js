{
  initComponent: function(){
    this.callParent();

    this.setDropEvent();

    this.setRefreshEvent();
  },

  setDropEvent: function() {
    this.on('drop', function(){
      var portlets = [];
      this.items.each(function(column){
        var columnPortlets = [];
        column.items.each(function(portlet){
          columnPortlets.push({
            item_id: portlet.itemId,
            // name: portlet.name,
            // title: portlet.title,
            // height: portlet.getHeight()
          });
        });
        portlets.push({items: columnPortlets});
      });

      this.serverUpdateLayout({layout: portlets});
    }, this);
  },

  setRefreshEvent: function() {
    setInterval(Ext.Function.bind(this.updateAllWidgets, this), 3000);
  },

  updateAllWidgets: function() {
    Ext.each(this.allPortlets(), function(portlet) {
      var netzkeWidget = portlet.items.first();
      if (netzkeWidget && Ext.isFunction(netzkeWidget.refresh)) netzkeWidget.refresh();

      // Also try 1 level up...
      if (Ext.isFunction(portlet.refresh)) portlet.refresh();
    });
  },

  // onOneColumnLayout: function() {
  //   var allPortlets = this.allPortlets();
  //
  //   this.add({items: allPortlets});
  //
  //   this.items.each(function(column) {
  //     column.destroy();
  //     return this.items.getCount() > 1;
  //   }, this);
  //
  //   // console.info("allPortlets: ", allPortlets);
  //
  // },

  allPortlets: function() {
    var portlets = [];

    this.items.each(function(column) {
      column.items.each(function(portlet) {
        portlets.push(portlet);
        // portlet.on('resize', function() {console.info("arguments: ", arguments);;});
      });
    });

    return portlets;
  },

  onAddServerStatsWidget: function() {
    var newPortlet = this.items.last().add({title: "Loading", height: 200});
    this.loadNetzkeComponent({name: "server_stats_widget", container: newPortlet, callback: function(cmp) {
      newPortlet.setTitle(cmp.title);
    }});
  }
}

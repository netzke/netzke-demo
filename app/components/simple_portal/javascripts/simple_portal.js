{
  initComponent: function(){
    this.callParent();

    this.setDropEvent();

    this.setRefreshEvent();

  },

  afterRender: function() {
    this.callParent(arguments);
    // incremented index for dynamically added components
    this.netzkePortletIndex = this.allPortlets().length;
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


  // Returns all Netzke portlets
  // protected
  allPortlets: function() {
    return this.query("portlet[isNetzke=true]");

    // var portlets = [];
    //
    // this.items.each(function(column) {
    //   column.items.each(function(portlet) {
    //     portlets.push(portlet);
    //     // portlet.on('resize', function() {console.info("arguments: ", arguments);;});
    //   });
    // });
    //
    // return portlets;
  },

  onAddServerStatsPortlet: function() {
    this.addPortlet("ServerStats");
  },

  onAddCpuChartPortlet: function() {
    this.addPortlet("CpuChart");
  },

  /*
  Params:
  * className
  * config - extra config for the portlet
  */
  addPortlet: function(className, config) {
    this.netzkeLoadComponent("netzke_" + this.netzkePortletIndex, {params: {class_name: className}, callback: function(c){
      this.items.last().add(c);
    }});
  }
}

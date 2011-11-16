{
  onOneColumnLayout: function() {
    var allPortlets = this.allPortlets();

    this.add({items: allPortlets});

    this.items.each(function(column) {
      column.destroy();
      return this.items.getCount() > 1;
    }, this);

    // console.info("allPortlets: ", allPortlets);

  },

  allPortlets: function() {
    var portlets = [];

    this.items.each(function(column) {
      column.items.each(function(portlet) {
        portlets.push(portlet);
        portlet.on('resize', function() {console.info("arguments: ", arguments);;});
      });
    });

    return portlets;
  }
}

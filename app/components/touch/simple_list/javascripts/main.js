{
  fullscreen: true,
  grouped : true,
  indexBar: true,

  initComponent: function() {
    Ext.regModel(this.model, {
        fields: this.attrs
    });

    var sortAttr = this.sortAttr;

    this.store = new Ext.data.JsonStore({
        model  : this.model,
        sorters: sortAttr,

        getGroupString : function(record) {
            return record.get(sortAttr)[0];
        },

        data: this.data
    });

    Netzke.classes.Touch.SimpleList.superclass.initComponent.call(this);
  }
}

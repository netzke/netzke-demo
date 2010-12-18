{
  initComponent: function() {
    Ext.regModel('Contact', {
        fields: ['firstName', 'lastName']
    });

    var store = new Ext.data.JsonStore({
        model  : 'Contact',
        sorters: 'lastName',

        getGroupString : function(record) {
            return record.get('lastName')[0];
        },

        data: this.data
    });

    Ext.apply(this, {
        fullscreen: true,

        itemTpl : '{firstName} {lastName}',
        grouped : true,
        indexBar: true,

        store: store
    });

    Netzke.classes.Touch.SimpleList.superclass.initComponent.call(this);
  }
}

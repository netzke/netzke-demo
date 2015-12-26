{
  initComponent: function(){
    this.viewConfig = {
      getRowClass: function(r){
        return r.get('salary') > 8000 ? "highlight" : "";
      }
    }
    this.callParent();
  }
}

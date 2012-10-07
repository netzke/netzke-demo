{
  initComponent: function() {
    this.callParent();

    this.navigation = this.down('panel[itemId="navigation"]');
    this.mainPanel = this.down('panel[itemId="main_panel"]');
    this.infoPanel = this.down('panel[itemId="info_panel"]');

    this.on('afterrender', function() {
      if (this.introHtml) this.updateInfo(this.introHtml);
    }, this);

    this.navigation.on('select', function(m, r) {
      this.loadNetzkeComponent({name: r.raw.component, container: this.mainPanel, callback: function(cmp) {
        this.updateInfo(cmp.desc);
      }, scope: this});
    }, this);
  },

  updateInfo: function(html) {
    this.infoPanel.body.update("<img style='position: relative; top: 3px; margin-right: 3px;' src='/images/icons/information.png' />" + html);
  },

  onAbout: function() {
    this.aboutWin = this.aboutWin || Ext.create('Ext.window.Window', {
      width: 400,
      height: 180,
      modal: true,
      title: "About",
      layout: 'fit',
      items: {
        border: false,
        bodyPadding: 5,
        html: '<h1>Netzke Demo</h2> <br/> \
        Explore demo <a target="_blank" href="http://netzke.org">Netzke</a> components along with their source code. <br/> \
        Follow <a target="_blank" href="http://twitter.com/netzke">@netzke</a> on Twitter for the latest news on the framework. <br/> \
        The source code for this app is on <a target="_blank" href="https://github.com/nomadcoder/netzke-demo">GitHub</a>. <br/> \
        <br/> \
        Copyright <a target="_blank" href="http://twitter.com/nomadcoder">Denis Gorin</a> 2012. \
        '
      }
    });

    this.aboutWin.show();
  }
}

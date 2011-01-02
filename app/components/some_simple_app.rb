class SomeSimpleApp < Netzke::Basepack::SimpleApp

  # Initial layout of the app.
  # <tt>status_bar_config</tt>, <tt>menu_bar_config</tt>, and <tt>main_panel_config</tt> are defined in SimpleApp.
  def configuration
    sup = super
    sup.merge(
      :items => [{
        :region => :north,
        :border => false,
        :height => 35,
        :html => %Q{
          <div style="margin:10px; color:#333; text-align:center; font-family: Helvetica;">
            <a style="color:#B32D15; text-decoration: none" href="http://netzke.org">Netzke</a> Demo
          </div>
        },
        :bodyStyle => {:background => %Q(#FFF url("/images/header-deco.gif") top left repeat-x)}
      },{
        :region => :center,
        :layout => :border,
        :border => false,
        :items => [status_bar_config, {
          :region => :center,
          :layout => :border,
          :items => [menu_bar_config, main_panel_config(:ref => "../../mainPanel"), {

            # Navigation
            :region => :west,
            :width => 200,
            :split => true,
            :xtype => :treepanel,
            :title => "Navigation",
            :root_visible => false,
            :ref => "../../navigation",
            :root => {
              :text => "Navigation",
              :expanded => true,
              :children => [{
                :text => "Simple Components",
                :expanded => true,
                :children => [{
                  :text => "Clerks",
                  :icon => uri_to_icon(:user),
                  :leaf => true,
                  :component => "clerks"
                },{
                  :text => "Bosses",
                  :icon => uri_to_icon(:user_suit),
                  :leaf => true,
                  :component => "bosses"
                },{
                  :text => "Custom Action Grid",
                  :leaf => true,
                  :component => "custom_action_grid"
                }]
              },{
                :text => "Composite Components",
                :expanded => true,
                :children => [{
                  :text => "Bosses And Clerks",
                  :icon => uri_to_icon(:user_user_suit),
                  :leaf => true,
                  :component => "bosses_and_clerks"
                }]
              },{
                :text => "Stand-alone Components",
                :leaf => true,
                :component => "embedded"
              }]
            }
          }]
        }]
      }]
    )
  end

  # Components
  component :clerks, :class_name => "Basepack::GridPanel", :model => "Clerk", :lazy_loading => true
  component :bosses, :class_name => "Basepack::GridPanel", :model => "Boss", :lazy_loading => true
  component :custom_action_grid, :model => "Boss", :lazy_loading => true
  component :bosses_and_clerks, :lazy_loading => true

  # A simple panel thit will render a page with links to different Rails views that have embedded widgets in them
  component :embedded, :class_name => "Basepack::Panel", :auto_load => "demo/embedded", :padding => 15, :title => "Components embedded into Rails views", :auto_scroll => true

  action :about, :icon => :information

  # Overrides SimpleApp#menu
  def menu
    ["->", :about.action]
  end

  js_method :on_about, <<-JS
    function(e){
      var msg = [
        '',
        'Source code for this demo: <a href="https://github.com/skozlov/netzke-demo">GitHub</a>.',
        '', '',
        '<div style="text-align:right;">Why follow <a href="http://twitter.com/nomadcoder">NomadCoder</a>?</div>'
      ].join("<br/>");

      Ext.Msg.show({
        width: 300,
         title:'About',
         msg: msg,
         buttons: Ext.Msg.OK,
         animEl: e.getId()
      });
    }
  JS


  # Overrides Ext.Component#initComponent to set the click event on the nodes
  js_method :init_component, <<-JS
    function(){
      Netzke.classes.SomeSimpleApp.superclass.initComponent.call(this);
      this.navigation.on('click', function(e){
        if (e.attributes.component) {
          this.appLoadComponent(e.attributes.component);
        }
      }, this);
    }
  JS

  # Overrides SimpleApp#process_history, to initially select the node in the navigation tree
  js_method :process_history, <<-JS
    function(token){
      if (token) {
        var node = this.navigation.root.findChild("component", token, true);
        if (node) node.select();
      }
      #{js_full_class_name}.superclass.processHistory.call(this, token);
    }
  JS

end

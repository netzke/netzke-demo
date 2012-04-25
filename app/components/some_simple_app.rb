class SomeSimpleApp < Netzke::Basepack::SimpleApp

  # Application layout
  # <tt>status_bar_config</tt>, <tt>menu_bar_config</tt>, and <tt>main_panel_config</tt> are defined in SimpleApp.
  def configure
    super
    config.items = [{
      :region => :north,
      :border => false,
      :height => 35,
      :html => %Q{
        <div style="margin:10px; color:#333; text-align:center; font-family: Helvetica; font-size: 150%;">
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
        :items => [menu_bar_config, main_panel_config, {

          layout: :border,
          border: false,
          region: :west,
          :width => 250,
          :split => true,
          items: [
            { region: :south, height: 150, title: "Info", body_padding: 5, html: "Info on selected component" },
            {
              region: :center,

              # Navigation
              :xtype => :treepanel,
              :title => "Navigation",
              :root_visible => false,
              :item_id => :navigation,
              :root => {
                :text => "Navigation",
                :expanded => true,
                :children => [{
                  :text => "Simple Components",
                  :expanded => true,
                  :children => [{
                    :text => "GridPanel",
                    :expanded => true,
                    :children => [{
                      :text => "Bosses",
                      :icon => uri_to_icon(:user_suit),
                      :leaf => true,
                      :component => "bosses"
                    },{
                      :text => "Clerks",
                      :icon => uri_to_icon(:user),
                      :leaf => true,
                      :component => "clerks"
                    },{
                      :text => "Customized Clerks",
                      :icon => uri_to_icon(:user),
                      :leaf => true,
                      :component => "customized_clerks"
                    },{
                      :text => "Custom Action Grid",
                      :leaf => true,
                      :component => "custom_action_grid"
                    }]
                  },{
                    :text => "FormPanel",
                    :expanded => true,
                    :children => [{
                      :text => "Clerks Paging Form",
                      :icon => uri_to_icon(:user),
                      :leaf => true,
                      :component => "clerk_paging_form"
                    },{
                      :text => "Clerks Paging Lockable Form",
                      :icon => uri_to_icon(:user),
                      :leaf => true,
                      :component => "clerk_paging_lockable_form"
                    },{
                      :text => "Clerks Paging Form, custom layout",
                      :icon => uri_to_icon(:user),
                      :leaf => true,
                      :component => "clerk_form_custom_layout"
                    }]
                  }]
                },{
                  :text => "Composite Components",
                  :expanded => true,
                  :children => [{
                    :text => "Bosses And Clerks",
                    :icon => uri_to_icon(:user_user_suit),
                    :leaf => true,
                    :component => "bosses_and_clerks",
                  },{
                    :text => "Simple Portal",
                    :leaf => true,
                    :component => "simple_portal"
                  }]
                },{
                  :text => "Stand-alone Components",
                  :leaf => true,
                  :component => "embedded"
                }]
              }
            }
          ]
        }]
      }]
    }]
  end

  # Components
  component :bosses do |c|
    c.klass = Netzke::Basepack::GridPanel
    c.model  = "Boss"
    c.title  = "Bosses"
    c.persistence  = true
  end

  component :clerks do |c|
    c.klass = Netzke::Basepack::GridPanel
    c.model  = "Clerk"
    c.title  = "Clerks"
    c.persistence  = true
  end

  component :customized_clerks do |c|
    c.klass = ClerkGrid
    c.title  = "Customized Clerks"
  end

  component :custom_action_grid do |c|
    c.model  = "Boss"
    c.title  = "Custom Action Grid"
    c.persistence  = true
  end

  component :bosses_and_clerks do |c|
    c.title  = "Bosses and Clerks"
  end

  component :clerk_paging_form do |c|
    c.title  = "Clerk Paging Form"
    c.model  = "Clerk"
    c.klass  = Netzke::Basepack::PagingFormPanel
  end

  component :clerk_paging_lockable_form do |c|
    c.title  = "Clerk Paging Lockable Form"
    c.model  = "Clerk"
    c.klass = Netzke::Basepack::PagingFormPanel
    c.mode  = :lockable
  end

  component :clerk_form_custom_layout do |c|
    c.klass  = ClerkForm
  end

  component :clerk_inspecto do |c|
    c.border  = false
    c.title  = "Simple Clerk Inspector"
  end

  # A simple panel thit will render a page with links to different Rails views that have embedded widgets in them
  component :embedded do |c|
    c.klass = Netzke::Basepack::Panel
    c.auto_load  = "demo/embedded"
    c.body_padding  = 15
    c.title  = "Components embedded into Rails views"
    c.auto_scroll  = true
  end

  component :simple_portal

  action :about do |c|
    c.icon  = :information
  end

  # Overrides SimpleApp#menu
  def menu
    ["->", :about]
  end

  js_method :on_about, <<-JS
    function(e){
      var msg = [
        '',
        'Source code for this demo: <a href="https://github.com/skozlov/netzke-demo">GitHub</a>.',
        '', '',
        '<div style="text-align:right;">Why follow <a href="http://twitter.com/nomadcoder">@NomadCoder</a>?</div>'
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
      this.callParent();
      this.navigation = this.query('panel[itemId="navigation"]')[0];
      this.navigation.getView().on('itemclick', function(e,r,i){
        if (r.raw.component) {
          this.appLoadComponent(r.raw.component);
        }
      }, this);
    }
  JS

  # Overrides SimpleApp#process_history, to initially select the node in the navigation tree
  js_method :process_history, <<-JS
    function(token){
      if (token) {
        var node = this.navigation.getStore().getRootNode().findChildBy(function(n){
          return n.raw.component == token;
        }, this, true);

        if (node) this.navigation.getView().select(node);
      }

      this.callParent([token]);
    }
  JS

end

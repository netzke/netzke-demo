module Netzke
  class BasicAppDemo < BasicApp
    #
    # Customizing the application layout. We can put any stuff we want in here,
    # the only agreement is to specify 2 fit panels with ids "main-panel" &
    # "main-toolbar" that will be used by Netzke::BasicApp.
    #
    def self.js_default_config
      # In status bar we want to show what we are masquerading as
      if session[:masq_user]
        masquerade_as = %Q{user "#{session[:masq_user].login}"}
      elsif session[:masq_role]
        masquerade_as = %Q{role "#{session[:masq_role].name}"}
      end

      super.merge({
        :layout => 'border',
        :items => [{
          :region => 'north',
          :height => 40,
          :html => %Q{
            <div style="margin:10px; color:#333; text-align:center; font-family: Helvetica;">
              <span style="color:#B32D15">Netzke</span> basic application demo
            </div>
          },
          :bodyStyle => {"background" => "#FFF url(\"/images/header-deco1.png\") top left repeat-x"}
        },{
          :region => 'center',
          :layout => 'border',
          :items => [{
            :id => 'main-panel',
            :region => 'center',
            :layout => 'fit'
          },{
      			:id => 'main-toolbar',
      			:xtype => 'toolbar',
            :region => 'north',
            :height => 25
          },{
            :id => 'main-statusbar',
            :xtype => 'statusbar',
            :region => 'south',
            :statusAlign => 'right',
            :busyText => 'Busy...',
            :default_text => masquerade_as.nil? ? "Ready" : "Masquerading as #{masquerade_as}",
            :default_icon_cls => ""
          }]
        }]
      })
    end

    #
    # Setting the "busy" indicator for Ajax requests
    #
    def self.js_after_constructor
      super << <<-JS
        Ext.Ajax.on('beforerequest', function(){this.findById('main-statusbar').showBusy()}, this);
        Ext.Ajax.on('requestcomplete', function(){this.findById('main-statusbar').hideBusy()}, this);
        Ext.Ajax.on('requestexception', function(){this.findById('main-statusbar').hideBusy()}, this);
      JS
    end

    #
    # Custom functions that co into BasicAppDemo class
    #
    def self.js_extend_properties
      super.merge({
        
        # Enter/exit config mode
        :config_mode => <<-JS.l,
          function(menuItem){
            Ext.Ajax.request({
              url : this.initialConfig.interface.toggleConfigMode,
              success : function(){
                window.location.reload();
              }
            })
          }
        JS
        
        # Masquerade selector window
        :show_masquerade_selector => <<-JS.l,
          function(){
            var w = new Ext.Window({
      				title: 'Masquerade as',
      				modal: true,
      				width: Ext.lib.Dom.getViewWidth() * 0.6,
              height: Ext.lib.Dom.getViewHeight() * 0.6,
              layout: 'fit',
      	      closeAction :'destroy',
              buttons: [{
                text: 'Select',
                handler : function(){
                  if (role = w.getWidget().masquerade.role) {
                    Ext.Msg.confirm("Masquerading as a role", "Individual preferences for all users with this role will get overwritten as you make changes. Continue?", function(btn){
                      if (btn === 'yes') {
                        w.close();
                      }
                    });
                  } else {
                    w.close();
                  }
                },
                scope:this
              },{
                text:'Turn off masquerading',
                handler:function(){
                  this.masquerade = {};
                  w.close();
                },
                scope:this
              },{
                text:'Cansel',
                handler:function(){
                  w.hide();
                },
                scope:this
              }],
              listeners : {close: {fn: function(){
                this.masqAs(this.masquerade || w.getWidget().masquerade || {});
              }, scope: this}}
      			});

      			w.show(null, function(){
      			  w.loadWidget("basic_app_demo__app_get_widget", {widget:"masqueradeSelector"});
      			}, this);
      			
          }
        JS
        
        # Masquerade as...
        :masq_as => <<-JS.l
          function(masqConfig){
            params = {};

            if (masqConfig.user) {
              params.user = masqConfig.user
            }

            if (masqConfig.role) {
              params.role = masqConfig.role
            }
            
            Ext.Ajax.request({
              url : this.initialConfig.interface.masqueradeAs,
              params : params,
              success : function(){
                window.location.reload();
              }
            });
          }
        JS
      })
    end

    #
    # Specify available actions for the application
    #
    def actions
      session = Netzke::Base.session
      
      { 
        :clerks            => {:text => "Clerks", :fn => "loadWidgetByAction"},
        :bosses            => {:text => "Bosses", :fn => "loadWidgetByAction"},
        :bosses_and_clerks => {:text => "Bosses and clerks", :fn => "loadWidgetByAction"},
        :masquerade_selector => {:text => "Masquerade as ...", :fn => "showMasqueradeSelector"},
        :users => {:text => "Users", :fn => "loadWidgetByAction"},
        :roles => {:text => "Roles", :fn => "loadWidgetByAction"},
        :toggle_config_mode => {:text => "#{session[:config_mode] ? "Leave" : "Enter"} config mode", :fn => "configMode"}
      }
    end
    
    #
    # Specify the menu
    #
    def menu
      common_menu = [{
        :text => "Go to",
        :menu => %w{ clerks bosses bosses_and_clerks }
      }]
      
      # only add the Admin menu when the user has role "administrator"
      if session[:user].try(:role).try(:name) == 'administrator'
        common_menu << {:text => "Admin", :menu => %w{ users roles toggle_config_mode masquerade_selector}}
      end
      
      common_menu
    end
    
    #
    # Prevent access to UserManager and roles for anonimous users
    #
    def interface_app_get_widget(params)
      widget = params[:widget].underscore
      if Netzke::Base.user.nil? && (widget == "users" || widget == 'roles')
        flash :error => "You don't have access to this widget"
        {:success => false, :flash => @flash}.to_js
      else
        super
      end
    end

    #
    # Interface
    #
    interface :masquerade_as, :toggle_config_mode
   
    def masquerade_as(params)
      session = Netzke::Base.session
      session[:masq_role] = params[:role] && Role.find(params[:role])
      session[:masq_user] = params[:user] && User.find(params[:user])
      {}
    end
    
    def toggle_config_mode(params)
      session = Netzke::Base.session
      session[:config_mode] = !session[:config_mode]
      {}
    end

    #
    # Make each child receive a configuration tool in config mode
    #
    def weak_children_config
      # reset config and masquerading modes if just logged in or logged out
      if session[:netzke_just_logged_in] || session[:netzke_just_logged_out]
        session[:config_mode] = false
        session[:masq_user] = session[:masq_roles] = nil
      end

      super.recursive_merge({:ext_config => {:config_tool => session[:config_mode]}});
    end
    
    #
    # Here are the widgets that our application will be able to load dynamically (see the demo for Netzke::GridPanel)
    #
    def initial_late_aggregatees
      {
        :clerks => {
          :widget_class_name => "BorderLayoutPanel",
          :ext_config => {
            :title => false
          },
          :regions => {
            :center => {
              :widget_class_name => "GridPanel", 
              :data_class_name => "Clerk", 
              :ext_config => {
                :title => 'Clerks',
                :rows_per_page => 20
              }
            },
            :south => {
              :widget_class_name => "Panel",
              :region_config => {
                :height => 190,
                :split => true,
                :collapsed => true,
                :collapsible => true
              },
              :ext_config => {
                :title => "Explanation",
                :body_style => "padding: 5px",
                :html => %Q{What you see is a BorderLayoutPanel-based compound widget, containing a GridPanel interfacing the Clerks model, and a Panel with a little explanation (the one you are reading). <br>What is here to play with: <br>1) Do some on-the-fly configuration of the grid - move around or resize its columns, change something in the columns configuration panel (click the tool-button in the up-right corner while in configuration mode), and then log out and in again - you'll see that your changes got stored; <br>2) Change the size of this (south) region - it'll get stored for you as well, by to the BorderLayoutPanel widget. <br>The same explanation naturally applies to the <a href="#bosses">bosses</a> view.
}
              }
            }
          }
        },

        :bosses => {
          :widget_class_name => "BorderLayoutPanel",
          :ext_config => {
            :title => false
          },
          :regions => {
            :center => {
              :widget_class_name => "GridPanel", 
              :data_class_name => "Boss", 
              :ext_config => {
                :title => "Bosses",
                :rows_per_page => 20
              }
            },
            :south => {
              :widget_class_name => "Panel",
              :region_config => {
                :height => 70,
                :collapsed => true,
                :collapsible => true,
                :split => true
              },
              :ext_config => {
                :title => "Explanation",
                :body_style => "padding: 5px",
                :html => %Q{See the explanations for the <a href="#clerks">clerks</a> view.}
              }
            }
          }
        },

        :bosses_and_clerks => {
          :widget_class_name    => "OneToManyGridSetPoc",
          :container_class_name => "Boss",
          :element_class_name   => "Clerk"
        },

        :masquerade_selector => {
          :widget_class_name => "MasqueradeSelector"
        },
        
        :roles => {
          :widget_class_name => "GridPanel",
          :data_class_name => "Role"
        },

        :users => {
          :widget_class_name => "BorderLayoutPanel",
          :ext_config => {
            :title => false,
            :border => false
          },
          :regions => {
            :center => {
              :widget_class_name => "UserManager"
            },
            :south => {
              :widget_class_name => "Panel",
              :region_config => {
                :height => 150,
                :collapsed => true,
                :collapsible => true,
                :split => true
              },
              :ext_config => {
                :title => "Explanation",
                :body_style => "padding: 5px",
                :html => %Q{Here you have a widget called UserManager, which extends the compound TableEditor widget (from netzke-pasepack), which in its turn consists of a GridPanel and a FormPanel working together.<br>Adding new users is done by filling out the form (see Rails validations kicking in).<br>Layouts for grid and form are configured separately by pressing the configuration tool-button on the top-right corner of each widget (in configuration mode).}
              }
            }
          }
        }
      }
    end
  end
end
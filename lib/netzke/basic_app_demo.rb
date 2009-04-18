module Netzke
  class BasicAppDemo < BasicApp
    #
    # Customizing the application layout. We can put any stuff we want in there,
    # the only agreement is to specify 2 fit panels with ids "main-panel" &
    # "main-toolbar" that will be used by Netzke::BasicApp.
    #
    def self.js_default_config
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
          }]
        }]
      })
    end

    #
    # Specify available "actions" for the application widget
    #
    def actions
      { 
        :clerks            => {:text => "Clerks", :fn => "loadWidgetByAction"},
        :bosses            => {:text => "Bosses", :fn => "loadWidgetByAction"},
        :bosses_and_clerks => {:text => "Bosses and clerks", :fn => "loadWidgetByAction"},
        
        # Only allow administrative actions when user is logged in
        :users => {:text => "Users", :fn => "loadWidgetByAction", :disabled => Netzke::Base.user.nil?}
      }
    end
    
    #
    # Specify the menus (simply specifying available action names)
    #
    def menu
      [{
        :text => "Go to",
        :menu => %w{ clerks bosses bosses_and_clerks users }
      }]
    end
    
    #
    # Prevent unauthorized access to Users
    #
    def interface_app_get_widget(params)
      widget = params[:widget].underscore
      if Netzke::Base.user.nil? && widget == "users"
        flash :error => "You don't have access to users"
        {:success => false, :flash => @flash}.to_js
      else
        super
      end
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
                :rows_per_page => 20,
                :config_tool => true
              }
            },
            :south => {
              :widget_class_name => "Panel",
              :region_config => {
                :height => 150,
                :split => true
              },
              :ext_config => {
                :title => false,
                :body_style => "padding: 5px",
                :html => %Q{
What you see is a BorderLayoutPanel-based compound widget, containing a GridPanel interfacing the Clerks data, and a Panel with a little explanation (the one you are reading). <br>What is here to play with: <br>1) Do some on-the-fly configuration of the grid - move around or resize its columns, change something in the columns configuration panel (click the tool-button in the up-right corner), and then log out and in again - you'll see that your changes got stored; <br>2) Change the size of this (south) region - it'll get stored for you as well, by to the BorderLayoutPanel widget. <br>The same explanation naturally applies to the <a href="#bosses">bosses</a> view.
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
                :rows_per_page => 20,
                :config_tool => true
              }
            },
            :south => {
              :widget_class_name => "Panel",
              :region_config => {
                :height => 50,
                :split => true
              },
              :ext_config => {
                :title => false,
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

        :users => {
          :widget_class_name => "BorderLayoutPanel",
          :ext_config => {
            :title => 'User manager'
          },
          :regions => {
            :center => {
              :widget_class_name => "UserManager"
            },
            :south => {
              :widget_class_name => "Panel",
              :region_config => {
                :height => 150,
                :split => true
              },
              :ext_config => {
                :title => false,
                :auto_scroll => true,
                :body_style => "padding: 5px",
                :html => %Q{Here you have a widget called UserManager, which extends the compound TableEditor widget (part of netzke-pasepack), which in its turn consists of a GridPanel and a FormPanel working together.<br>Adding new users is done by filling out the form (see Rails' validations kicking in).<br>Layouts for grid and form are configured separately (by pressing the configuration tool-button on the top-right corner of each widget). See how {"inputType":"password"} is specified in the "Ext config" column for the form - this is how you get the password masked. This way you may specify any additional configuration parameters understood by any Ext.form.Field-derived component. Later the FieldConfigurator will probably provide a GUI for editing this extra configuration, but for now the JSON code can only be edited by hand. But! If you add a column named "input_type" to netzke_form_panel_fields table, this configuration option will get magically over-taken by that column, instead of being present in "Ext config" (this is true for any other configuration option for Ext.form.Field, of course)}
              }
            }
          }
        }
      }
    end
  end
end
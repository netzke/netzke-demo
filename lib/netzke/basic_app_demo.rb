module Netzke
  class BasicAppDemo < BasicApp
    #
    # Specify the menus
    #
    def self.js_initial_menus
      [{
          :text => "Go to",
          :menu => {
            :items => [{
              :text => "Clerks",
              :handler => "this.appLoadWidget".l,
              :widget => 'clerks',
              :scope => this
            },{
              :text => "Bosses",
              :handler => "this.appLoadWidget".l,
              :widget => 'bosses',
              :scope => this
            }]
          }
        },{
          :text => "Administration",
          :menu => {
            :items => [{
              :text => "Users",
              :handler => "this.appLoadWidget".l,
              :widget => 'users',
              :scope => this
            }]
          }
        }] + super
    end
    
    #
    # Here are the widgets that our application will be able to load dynamically (see the demo for Netzke::GridPanel)
    #
    def initial_late_aggregatees
      {
        :clerks => {
          :widget_class_name => "GridPanel", 
          :data_class_name => "Clerk", 
          :ext_config => {
            :title => "Clerks",
            :rows_per_page => 20,
            :config_tool => true
          }
        },
        :bosses => {
          :widget_class_name => "GridPanel", 
          :data_class_name => "Boss", 
          :ext_config => {
            :title => "Bosses",
            :rows_per_page => 20,
            :config_tool => true
          }
        },
        :users => {
          :widget_class_name => "GridPanel", 
          :data_class_name => "User", 
          :ext_config => {
            :title => "Users"
          },
          :prohibit => :delete
        }
      }
    end
  end
end
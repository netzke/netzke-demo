module Netzke
  class BossesAndClerks < BorderLayoutPanel
    def default_config
      super.merge({
        :regions => {
          :center => {
            :widget_class_name => "GridPanel",
            :data_class_name => "Boss",
            :ext_config => {
              :title => "Bosses"
            }
          },
          :east => {
            :widget_class_name => "Panel",
            :ext_config => {
              :title => "Info",
              :body_style => {:padding => "5px 5px"}
            },
            :region_config => {
              :width => 240,
              :split => true
            }
          },
          :south => {
            :widget_class_name => "GridPanel",
            :data_class_name => "Clerk",
            :scopes => [[:boss_id, widget_session[:selected_boss_id]]],
            :ext_config => {
              :title => "Clerks"
            },
            :region_config => {
              :height => 200,
              :split => true
            }
          }
        },
        :ext_config => {
          :header => false
        }
      })
    end
    
    def self.js_extend_properties
      super.merge({
        :init_component => <<-END_OF_JAVASCRIPT.l,
          function(){
            Ext.netzke.cache.#{short_widget_class_name}.superclass.initComponent.call(this);
            
            // Set the selection changed event
            this.getCenterWidget().on('rowclick', this.onBossSelectionChanged, this);
          }
        END_OF_JAVASCRIPT
        
        :on_boss_selection_changed => <<-END_OF_JAVASCRIPT.l,
          function(self, rowIndex){
            this.selectBoss({boss_id: self.store.getAt(rowIndex).get('id')});
          }
        END_OF_JAVASCRIPT
      })
    end
    
    api :select_boss
    def select_boss(params)
      # store selected boss id in the session for this widget's instance
      widget_session[:selected_boss_id] = params[:boss_id]
      
      # boss
      boss = Boss.find(params[:boss_id])
      
      # instantiate the widget
      clerks_grid = aggregatee_instance(:south)

      # pass 
      {
        :south => {:load_store_data => clerks_grid.get_data, :set_title => "Clerks for #{boss.name}"}, 
        :east => {:update_body_html => boss_info_html(params[:boss_id]), :set_title => "#{boss.name}"},
      }
    end
    
    def boss_info_html(id)
      boss = Boss.find(id)
      res = "<h1>Statistics on clerks</h1>"
      res << "Number: #{boss.clerks.count}<br/>"
      res << "With salary > $5,000: #{boss.clerks.salary_gt(5000).count}<br/>"
      res << "To lay off: #{boss.clerks.subject_to_lay_off_eq(true).count}<br/>"
      res
    end
  end
end
module Netzke
  class WidgetUpdateDemo < BorderLayoutPanel
    interface :update_panels
    
    def initialize(*args)
      super
      
      config[:regions] = {
        :center => {:widget_class_name => 'Panel'},
        :east => {:widget_class_name => 'Panel', :region_config => {:width => 200, :split => true, :collapsible => true}}
      }
    end
    
    def self.js_after_constructor
      <<-END_OF_JAVASCRIPT
        this.justUpdatePanels.defer(1000, this);
      END_OF_JAVASCRIPT
    end
    
    def self.js_extend_properties
      super.merge({
        :just_update_panels => <<-END_OF_JAVASCRIPT.l,
          function(){
            this.updatePanels({bla:"Cool!"});
          }
        END_OF_JAVASCRIPT
      })
    end
    
    # interface
    def update_panels(params = {})
      [
        {:widget => 'center', :methods => [{:set_title => 'Center'}]},
        {:widget => 'east', :methods => [{:set_title => 'We are disabled :)', :set_disabled => true}]},
        {:set_title => "Main panel"}
      ]
    end
  end
end
module Netzke
  # Proof of concept for two grids that are related by one-to-many association
  class OneToManyGridSetPoc < BorderLayoutPanel
    # Two grids as regions
    def default_config
      super.merge({
        :ext_config => {
          :header => false
        },
        :regions => {
          :center => {
            :class_name    => "GridPanel", 
            :model      => @passed_config[:container_class_name],
            :ext_config => {
              :title         => @passed_config[:container_class_name].pluralize
            }
          }.deep_merge(@passed_config[:container_config] || {}),

          :east => {
            :class_name    => "GridPanel",
            :model      => @passed_config[:element_class_name],
            :scopes               => [[:boss_id, widget_session[:container_id]]],
            :strong_default_attrs => {:boss_id => widget_session[:container_id]},
            :region_config        => {
              :width  => 300, 
              :split  => true
            },
            :ext_config => {
              :title         => @passed_config[:element_class_name].pluralize
            }
          }.deep_merge(@passed_config[:element_config] || {})
        }
      })
    end

    def self.js_extend_properties
      super.merge({
        :init_component => <<-END_OF_JAVASCRIPT.l,
          function(){
            #{js_full_class_name}.superclass.initComponent.call(this);

            var setCentralWidgetEvents = function(){
              this.getCenterWidget().getSelectionModel().on('rowselect', this.containerSelectionChanged, this);
            };
            this.getCenterWidget().ownerCt.on('add', setCentralWidgetEvents, this);
            setCentralWidgetEvents.call(this);
          }
        END_OF_JAVASCRIPT
        
        :container_selection_changed => <<-END_OF_JAVASCRIPT.l,
          function(selModel){
            this.selectContainer({container_id:selModel.getSelected().get('id')});
          }
        END_OF_JAVASCRIPT
        
      })
    end

    api :select_container
    def select_container(params)
      update = []

      widget_session[:container_id] = params[:container_id]

      contact_list = aggregatee_instance(:east)

      update << {:east => [:load_store_data => contact_list.get_data(:with_last_params => true)]}
      
      update
    end
  
    
  end
end
  
module Netzke
  class OneToManyGridSetPoc < BorderLayoutPanel
    #
    # Two grids as aggregatees
    #
    def initial_aggregatees
      {
        :center => {
          :widget_class_name    => "GridPanel", 
          :data_class_name      => config[:container_class_name],
          :ext_config => {
            :rows_per_page => 20,
            :title         => config[:container_class_name].pluralize
          }
        }.recursive_merge(config[:container_config] || {}),
        
        :east => {
          :widget_class_name    => "GridPanel", 
          :data_class_name      => config[:element_class_name],
          :region_config        => {
            :width  => 300, 
            :split  => true
          },
          :ext_config => {
            :rows_per_page => 20,
            :title         => config[:element_class_name].pluralize
          }
        }.recursive_merge(config[:element_config] || {})
      }
    end
    
    def initial_config
      super.merge({
        :ext_config => {
          :title => false
        }
      })
    end
    
    def self.js_after_constructor
      super << <<-END_OF_JAVASCRIPT
        var setCentralWidgetEvents = function(){
          this.getCenterWidget().on('rowclick', this.onRowClick, this);
        };
        this.getCenterWidget().ownerCt.on('add', setCentralWidgetEvents, this);
        setCentralWidgetEvents.call(this);
      END_OF_JAVASCRIPT
    end

    def self.js_extend_properties
      super.merge({
        :on_row_click => <<-END_OF_JAVASCRIPT.l
          function(grid, index, e){
        		// get id of the selected boss
            var id = this.getCenterWidget().getStore().getAt(index).get('id');

            // load the east grid, appending to the request the id of the selected boss
            var contentGrid = this.getEastWidget();
            contentGrid.store.baseParams = {container_id:id};
            contentGrid.store.reload();
          }
        END_OF_JAVASCRIPT
      })
    end

    def east__get_data(params)
      # extract Ext filters from params (we want them keep on working)
      filters = params[:filter] ||= {}

      # calculate the foreign key based on container class
      foreign_key = aggregatees[:center][:data_class_name].
                    constantize.table_name.singularize + "_id"

      # add the foreign key filter to the filters
      filters.merge!({:our_fkey_filter => {
        :data => {:value => params[:container_id], :type => "integer"}, 
        :field => foreign_key}
      })

      # call the original get_data method, but with updated filters
      method_missing(:east__get_data, params.merge(:filter => filters))
    end


    def east__post_data(params)
      container_id = params[:base_params] && 
        ActiveSupport::JSON.decode(params[:base_params])["container_id"]

      foreign_key = aggregatees[:center][:data_class_name].
                    constantize.table_name.singularize + "_id"

      # for new records, merge foreign key in
      new_records = params[:created_records] && 
        ActiveSupport::JSON.decode(params.delete(:created_records))
      if new_records
        for r in new_records
          r.merge!(foreign_key => container_id)
        end
      end
      
      # call the original get_data method, but with corrected params
      method_missing(:east__post_data, params.merge(:created_records => new_records.to_json))
    end
  
    
  end
end
  
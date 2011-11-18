module Portlet
  class CpuChart < Base

    title "CPU usage"

    items [{
      xtype: 'chart',
      shadow: false,
      animate: false,
      height: 180,
      width: 200,
      theme: 'Base:gradients',
      store: {
        xtype: 'jsonstore',
        fields: ['data1'],
        data: [{data1: 100}]
      },
      axes: [{
        type: :gauge,
        position: :gauge,
        minimum: 0,
        maximum: 200,
        steps: 10,
        margin: 10
      }],
      animate: {
        easing: 'elasticIn',
        duration: 1000
      },
      series: [{
        type: 'gauge',
        donut: 30,
        field: :data1
      }]
    }]


    js_method :init_component, <<-JS
      function(){
        this.callParent();

        if (this.autoUpdate) Ext.Function.defer(this.refresh, 2000, this);
      }
    JS

    js_method :refresh, <<-JS
      function(){
        this.serverGetStats({}, function(value){
          this.items.first().store.loadData([{data1: value*100}]);
        });
      }
    JS

    endpoint :server_get_stats do |params|
      {:set_result => cpu_usage}
    end

    def cpu_usage
      `uptime`.split[-3].to_f
    end

  end
end
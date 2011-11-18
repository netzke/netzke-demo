module Portlet
  class ServerStats < Base

    title "Server stats"

    def stats_html
      [
        "<b>CPU:</b> #{cpu_usage}",
        "<b>RAM (fake):</b> #{rand(100)}%"
      ].join("<br/>")
    end

    def cpu_usage
      `uptime`.split[-3]
    end

    def default_config
      super.tap do |c|
        c[:items] = [{
          body_padding: 5,
          html: stats_html
        }]
      end
    end

    js_method :init_component, <<-JS
      function(){
        this.callParent();

        if (this.autoUpdate) Ext.Function.defer(this.refresh, 2000, this);
      }
    JS

    js_method :refresh, <<-JS
      function(){
        this.serverGetStats({}, function(html){
          this.items.first().body.update(html);
          if (this.autoUpdate) Ext.Function.defer(this.refresh, 2000, this);
        });
      }
    JS

    endpoint :server_get_stats do |params|
      {:set_result => stats_html}
    end
  end
end

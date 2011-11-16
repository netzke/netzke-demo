class ServerStatsWidget < Netzke::Base
  js_property :body_padding, 5

  def stats_html
    "<h1>CPU: #{cpu_usage}</h1>"
  end

  def cpu_usage
    `uptime`.split[-3]
  end

  def configuration
    super.tap do |c|
      c[:html] = stats_html
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
        this.body.update(html);
        if (this.autoUpdate) Ext.Function.defer(this.refresh, 2000, this);
      });
    }
  JS

  endpoint :server_get_stats do |params|
    {:set_result => stats_html}
  end
end
class BossDetails < Netzke::Base

  client_class do |c|
    c.body_padding = 5
    c.title = "Info"
    c.update_stats = <<-JS
      function(){
        // Create and show the mask
        this.getEl().mask();

        // Call endpoint
        this.serverUpdate({}, function(){
          // Hide mask (we're in the callback function)
          this.getEl().unmask();
        }, this);
      }
    JS
  end

  endpoint :server_update do |params|
    # updateBodyHtml is a JS-side method we inherit from Netkze::Basepack::Panel

    this[:update] = [body_content(boss)]
    this.set_title boss.name
  end

  # HTML template used to display the stats
  def body_content(boss)
    %Q(
      <h2>Statistics on clerks</h2>
      Number: #{boss.clerks.count}<br/>
      With salary > $5,000: #{boss.clerks.where(["salary >= ?", 5000]).count}<br/>
      To lay off: #{boss.clerks.where(:subject_to_lay_off => true).count}
    ) if boss
  end

private
  def boss
    @boss ||= config[:boss_id] && Boss.find(config[:boss_id])
  end

end

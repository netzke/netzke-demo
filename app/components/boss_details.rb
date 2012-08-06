class BossDetails < Netzke::Basepack::Panel

  js_configure do |c|
    c.body_padding = 5
    c.title = "Info"
    c.update_stats = <<-JS
      function(){
        // Create and show the mask
        if (!this.maskCmp) this.maskCmp = new Ext.LoadMask(this.getEl(), {msg: "Updating..."});
        this.maskCmp.show();

        // Call endpoint
        this.update({}, function(){
          // Hide mask (we're in the callback function)
          this.maskCmp.hide();
        }, this);
      }
    JS
  end

  endpoint :update do |params, this|
    # updateBodyHtml is a JS-side method we inherit from Netkze::Basepack::Panel

    this.update_body_html body_content(boss)
    this.set_title boss.name
  end

  # HTML template used to display the stats
  def body_content(boss)
    %Q(
      <h1>Statistics on clerks</h1>
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

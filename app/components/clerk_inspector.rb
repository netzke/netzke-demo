# Displays a grid panel on the left, and the form on the right. When a row in the grid panel is clicked, the form panel dynamically loads the corresponding record.
class ClerkInspector < Netzke::Basepack::BorderLayoutPanel
  component :clerk_grid, :class_name => "Netzke::Basepack::GridPanel", :model => "Clerk", :columns => [:name]
  component :clerk_form, :class_name => "Netzke::Basepack::FormPanel", :model => "Clerk"

  def default_config
    super.tap do |c|
      c[:items] = [
        :clerk_grid.component(:region => :west, :width => 250, :split => true, :title => "List"),
        :clerk_form.component(:region => :center, :title => "Details")
      ]
    end
  end

  js_method :init_component, <<-JS
    function(){
      this.callParent();

      this.clerkGrid = this.getComponent('clerk_grid');
      this.clerkForm = this.getComponent('clerk_form');

      // When a row is clicked in the clerk grid, make the clerk form load the corresponding record
      this.clerkGrid.on('itemclick', function(view, record){
        this.clerkForm.netzkeLoad({id: record.getId()});
      }, this);
    }
  JS
end
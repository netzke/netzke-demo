class DemoController < ApplicationController
  def index
    render :layout => false
  end

  netzke :grid_panel, :data_class_name => "Boss", :ext_config => {:mode => :config}
  netzke :form_panel, :data_class_name => "Boss", :ext_config => {:title => "Bosses", :mode => :config}

end

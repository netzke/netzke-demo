class BasicAppController < ApplicationController
  before_filter :configure_netzke
  
  netzke :basic_app_demo
  
  def intro
    render :layout => false
  end
  
  def index
    redirect_to :action => "intro"
  end

end

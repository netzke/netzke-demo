class BasicAppController < ApplicationController
  before_filter :require_user, :only => :demo
  
  netzke :basic_app_demo
  
  def intro
    render :layout => false
  end
end

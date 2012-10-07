class DemoController < ApplicationController
  layout "application"
  def index
    render :inline => "<% title 'Demo App', false %><%= netzke :application %>", :layout => true
  end
end

class DemoController < ApplicationController
  def index
    render :inline => "<% title 'Demo App', false %><%= netzke :application %>", :layout => true
  end
end

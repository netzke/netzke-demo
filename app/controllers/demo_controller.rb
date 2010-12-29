class DemoController < ApplicationController
  layout "application"
  def index
    render :inline => "<% title 'Netzke Demo', false %><%= netzke :some_simple_app %>", :layout => true
  end
end

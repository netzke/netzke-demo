class ComponentsController < ApplicationController
  def index
    component_name = params[:component].gsub("::", "__").underscore
    render :inline => "<% title #{params[:component]}, false %>", :layout => true
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery
  def index
    render :inline => "<%= netzke :application %>", layout: true
  end
end

class BasicAppController < ApplicationController
  # before_filter :require_user, :only => :demo

  def intro
    render :layout => false
  end
  
  def index
    redirect_to :action => "intro"
  end

end

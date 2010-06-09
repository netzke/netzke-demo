class BasicAppController < ApplicationController

  def intro
    render :layout => false
  end

  # to not break someone's links
  def demo
    redirect_to :action => "index", :status=>:moved_permanently
  end

end

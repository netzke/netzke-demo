class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.new(params[:user].merge(:role => Role.find_by_name('administrator')))
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default "/basic_app/demo"
    else
      render :action => :new
    end
  end
  
end

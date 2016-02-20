class HomeController < ApplicationController
  def index
    @is_logged_in = logged_in?
    
    if @is_logged_in
      @first_name = logged_in_user.first_name
      @last_name  = logged_in_user.last_name
    end
  end

  def forgot
  end
  
  # PUT /bulb
  def update_bulb_opacity
    session[:bulb_opacity] = params[:opacity]
    render :json => true
  end
end

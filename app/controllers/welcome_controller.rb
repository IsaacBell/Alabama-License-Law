class WelcomeController < ApplicationController
  
  def form
            
  end
  
  def form_process
    # Do something
    resp = Caboose::StdClass.new({
      'error' => nil,
      'succes' => nil
    })
    
    # Render json
    render :json => resp
  end
  
end

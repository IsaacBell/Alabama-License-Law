class BookmarksController < ApplicationController
  
  # GET /bookmarks
  def index
    arr = logged_in? ? Bookmark.where(:user_id => logged_in_user.id).reorder(:law_id).all : []    
    render :json => arr, :include => :law
  end
  
  # POST /bookmarks
  def add
    resp = Caboose::StdClass.new    
    if logged_in?      
      user_id = logged_in_user.id          
      if !Bookmark.exists?(:law_id => params[:law_id], :user_id => user_id) 
        b = Bookmark.new(:law_id => params[:law_id], :user_id => user_id)
        b.save
        resp = b
      end
    end
    render :json => resp
  end

  # DELETE /bookmarks/:id
  def delete
    if logged_in? && Bookmark.exists?(params[:id])
      Bookmark.find(params[:id]).destroy
      render :json => true
      return
    end
    render :json => false
  end

end

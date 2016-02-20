class LawsController < ApplicationController

  # GET /laws
  def index
    @index = true
    @is_logged_in = logged_in?
    if @is_logged_in
      @user = logged_in_user
    end
    render "show"
  end

  # GET /laws/:id
  def show
    id = params[:id]
    @law = Law.exists?(:legal_id => id) ? Law.where(:legal_id => id).first : nil    
  	@law = Law.find(id) if @law.nil? && Law.exists?(id)
  	
  	if @law
  	  @next_law = @law.getNextLaw
  	  @prev_law = @law.getPrevLaw
  	  @is_logged_in = logged_in?
  	  @user = logged_in_user
  	  @bookmark = Bookmark.exists?(:law_id => @law.id, :user_id => @user.id) ? 
  	    Bookmark.where(:law_id => @law.id, :user_id => @user.id).first : nil
  	end
  end

  # GET /laws/get-law
  def get_law
    law = nil
    if params[:id]
      law = Law.find(params[:id])
    elsif params[:legal_id]
      law = Law.where(:legal_id => params[:legal_id]).first
    end
  	render :json => law
  end

  # GET /laws/search/:query
  def search
    if logged_in?
      @user = logged_in_user
    end
    query = params[:query]
    @laws = Law.where("LOWER(content) like LOWER(?) OR LOWER(title) like LOWER(?)", "%#{query}%", "%#{query}%")
  end
  
  #=============================================================================
  # Admin actions
  #=============================================================================
  
  # GET /admin/laws
  def admin_index
    return if !user_is_allowed('laws', 'view')
    
    @gen = Caboose::PageBarGenerator.new(params, {
        'category_id'   => '',
  		  'legal_id_like' => '',		  
  		  'title_like'    => '',
  		  'content_like'  => ''  		  
  		},{
  		  'model'       => 'Law',
  	    'sort'			  => 'legal_id',
  		  'desc'			  => false,
  		  'base_url'		=> '/admin/laws'
  	})
  	@laws = @gen.items
  	render :layout => 'caboose/admin'
  end
  
  # GET /admin/laws/new
  def admin_new
    return if !user_is_allowed('laws', 'add')
    @law = Law.new
    render :layout => 'caboose/admin'
  end
  
  # GET /admin/laws/:id/edit
  def admin_edit
    return if !user_is_allowed('laws', 'edit')
    @law = Law.find(params[:id])    
    render :layout => 'caboose/admin'
  end
  
  # POST /admin/laws
  def admin_add
    return if !user_is_allowed('laws', 'add')
    
    resp = Caboose::StdClass.new({
        'error' => nil,
        'redirect' => nil
    })
    
    law = Law.new
    law.legal_id = params[:legal_id]
    law.law_category_id = LawCategory.first.id
    
    if law.legal_id.length == 0
      resp.error = "A legal ID is required."
    elsif Law.exists?(:legal_id => law.legal_id)
      resp.error = "A law with that legal ID already exists."
    else
      law.save
      resp.redirect = "/admin/laws/#{law.id}"
    end
    render :json => resp
  end
  
  # PUT /admin/laws/:id
  def admin_update
    return if !user_is_allowed('laws', 'edit')
  
    resp = Caboose::StdClass.new({
      'attributes' => {}
    })
    law = Law.find(params[:id])
  
    save = true
    params.each do |name,value|
      case name
  	  	when "legal_id", "title", "content"
  	  	  law[name.to_sym] = value
  	  	when "law_category_id"
  	  	  law.law_category_id = value
  	  	  cat = LawCategory.find(value)
  	  	  resp.attributes['law_category_id'] = { 'text' => cat.title } 
  	  end
  	end
  	
  	resp.success = save && law.save
  	render :json => resp
  end
    
  # DELETE /admin/laws/:id
  def admin_delete
    return if !user_is_allowed('laws', 'delete')
    law = Law.find(params[:id])
    law.destroy
    
    resp = Caboose::StdClass.new({
      'redirect' => '/admin/laws'
    })
    render :json => resp
  end
  
end

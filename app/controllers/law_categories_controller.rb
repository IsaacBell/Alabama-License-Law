class LawCategoriesController < ApplicationController
  
  #=============================================================================
  # Admin actions
  #=============================================================================
  
  # GET /admin/law-categories
  def admin_index
    return if !user_is_allowed('laws', 'view')
    
    @gen = PageBarGenerator.new(params, {
        'title_like'    => '',
  		  'subtitle_like' => '',
  		},{
  		  'model'       => 'LawCategory',
  	    'sort'			  => 'title',
  		  'desc'			  => false,
  		  'base_url'		=> '/admin/law-categories'
  	})
  	@cats = @gen.items
  end
  
  # GET /admin/law-categories/new
  def admin_new
    return if !user_is_allowed('laws', 'add')
    @cat = LawCategory.new
  end
  
  # GET /admin/law-categories/:id
  def admin_edit
    return if !user_is_allowed('laws', 'edit')
    @cat = LawCategory.find(params[:id])    
  end
  
  # POST /admin/law-categories
  def admin_add
    return if !user_is_allowed('laws', 'add')
    
    resp = StdClass.new({
        'error' => nil,
        'redirect' => nil
    })
    
    cat = LawCategory.new
    law.title = params[:title]
    
    if cat.title.length == 0
      resp.error = "A legal ID is required."
    elsif LawCategory.exists?(:title => cat.title)
      resp.error = "A category with that title already exists."
    else
      cat.save
      resp.redirect = "/admin/law-categories/#{cat.id}"
    end
    render :json => resp
  end
  
  # PUT /admin/law-categories/:id
  def admin_update
    return if !user_is_allowed('laws', 'edit')
  
    resp = StdClass.new     
    cat = LawCategory.find(params[:id])
  
    save = true
    params.each do |name,value|
      case name
  	  	when "title", "subtitle"
  	  	  cat[name.to_sym] = value  	  	    		  
  	  end
  	end
  	
  	resp.success = save && cat.save
  	render :json => resp
  end
    
  # DELETE /admin/law-categories/:id
  def admin_delete
    return if !user_is_allowed('laws', 'delete')    
    LawCategory.find(params[:id]).destroy    
    render :json => StdClass.new(
      'redirect' => '/admin/law-categories'
    )    
  end
  
  # GET /admin/law-categories/options
  def admin_options    
    return if !user_is_allowed('laws', 'view')
    
    options = LawCategory.reorder('title').all.collect { |cat| 
      { 
        'value' => cat.id, 
        'text' => cat.title   
      } 
    }
    render :json => options
  end
  
end

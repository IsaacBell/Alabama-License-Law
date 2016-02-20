class CategoriesController < ApplicationController

  #=============================================================================
  # Admin actions
  #=============================================================================
  
  # GET /admin/categories
  def admin_index
    return if !user_is_allowed('categories', 'view')
    
    @gen = PageBarGenerator.new(params, {
  		  'title_like'    => ''  		  
  		},{
  		  'model'       => 'Category',
  	    'sort'			  => 'title',
  		  'desc'			  => false,
  		  'base_url'		=> '/admin/categories'
  	})
  	@categories = @gen.items
  end
  
  # GET /admin/categories/new
  def admin_new
    return if !user_is_allowed('categories', 'add')
    @category = Category.new
  end
  
  # GET /admin/categories/:id
  def admin_edit
    return if !user_is_allowed('categories', 'edit')
    @category = Category.find(params[:id])    
  end
  
  # POST /admin/categories
  def admin_add
    return if !user_is_allowed('categories', 'add')
    
    resp = StdClass.new({
        'error' => nil,
        'redirect' => nil
    })
    
    category = Category.new
    category.title = params[:title]
    
    if category.title.length == 0
      resp.error = "A title is required."
    else
      category.save
      resp.redirect = "/admin/categories/#{category.id}/edit"
    end
    render :json => resp
  end
  
  # PUT /admin/categories/:id
  def admin_update
    return if !user_is_allowed('categories', 'edit')
  
    resp = StdClass.new     
    category = User.find(params[:id])
  
    save = true
    params.each do |name,value|
      case name
  	  	when "title", "subtitle", "parent_id"
  	  	  category[name.to_sym] = value  	  	    		  
  	  end
  	end
  	
  	resp.success = save && category.save
  	render :json => resp
  end
    
  # DELETE /admin/categories/:id
  def admin_delete
    return if !user_is_allowed('categories', 'delete')
    Category.find(params[:id]).destroy    
    resp = StdClass.new('redirect' => '/admin/categories')
    render :json => resp
  end
  
  # GET /admin/categories/options
  def admin_options    
    return if !user_is_allowed('categories', 'view')
    
    @categories = User.reorder('last_name, first_name').all
    options = @categories.collect { |u| { 'value' => u.id, 'text' => "#{u.first_name} #{u.last_name}"}}
    render json: options
  end
  
end

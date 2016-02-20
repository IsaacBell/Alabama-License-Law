Licenselaw::Application.routes.draw do

  put   "bulb"                  => "home#update_bulb_opacity"
  
  get 	"laws"		  				   	=> "laws#index"
  get   "laws/search"           => "laws#search"
  get 	"laws/get-law" 			    => "laws#get_law"
  get 	"laws/:id"	 	  	      => "laws#show", :constraints  => { :id => /[0-z\-\.]+/ }
  
  get     "admin/laws"          => "laws#admin_index"
  get     "admin/laws/new"      => "laws#admin_new"
  post    "admin/laws"          => "laws#admin_add"
  get     "admin/laws/:id"      => "laws#admin_edit"
  put     "admin/laws/:id"      => "laws#admin_update"
  delete  "admin/laws/:id"      => "laws#admin_delete"
  
  get     "admin/law-categories"          => "law_categories#admin_index"
  get     "admin/law-categories/options"  => "law_categories#admin_options"
  get     "admin/law-categories/new"      => "law_categories#admin_new"
  post    "admin/law-categories"          => "law_categories#admin_add"
  get     "admin/law-categories/:id"      => "law_categories#admin_edit"
  put     "admin/law-categories/:id"      => "law_categories#admin_update"
  delete  "admin/law-categories/:id"      => "law_categories#admin_delete"
    
  #post  "laws/bookmarks"        => "laws#bookmarks"
  #post  "laws/add_bookmark"     => "laws#add_bookmark"
  #post  "laws/remove_bookmark"  => "laws#remove_bookmark"
  
  get     "bookmarks"           => "bookmarks#index"
  post    "bookmarks"           => "bookmarks#add"
  delete  "bookmarks/:id"       => "bookmarks#delete"
    
  get 	"form"          				=> "welcome#form"
  get 	"form-process"  				=> "welcome#form_process"

  get   "forgot"                => "home#forgot"

  root to: 'home#index'
  
	# Catch everything with caboose
	mount Caboose::Engine => '/'
	match '*path' => 'caboose/pages#show'
	

end

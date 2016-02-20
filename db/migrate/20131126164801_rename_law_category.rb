class RenameLawCategory < ActiveRecord::Migration
  def change
    rename_table :categories, :law_categories
    remove_column :law_categories, :created_at
    remove_column :law_categories, :updated_at
    remove_column :law_categories, :parent
    rename_column :laws, :category_id, :law_category_id    
  end
end

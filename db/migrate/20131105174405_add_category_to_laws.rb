class AddCategoryToLaws < ActiveRecord::Migration
  def change
    add_column :laws, :category, :int
  end
end

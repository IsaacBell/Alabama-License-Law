class AddParentToCateogry < ActiveRecord::Migration
  def change
    add_column :categories, :parent, :int
  end
end

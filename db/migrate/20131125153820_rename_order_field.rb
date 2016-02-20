class RenameOrderField < ActiveRecord::Migration
  def change
    rename_column :laws, :order, :position
  end
end

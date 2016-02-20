class RenameFields < ActiveRecord::Migration
  def change
    rename_column :savedlaws, :lawid, :law_id
    rename_column :savedlaws, :userid, :user_id
    rename_table :savedlaws, :bookmarks    
  end
end

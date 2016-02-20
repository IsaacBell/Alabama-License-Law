class RenameLegal < ActiveRecord::Migration
  def change
    rename_column :laws, :legalID, :legal_id        
  end
end

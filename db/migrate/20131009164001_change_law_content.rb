class ChangeLawContent < ActiveRecord::Migration
  def change
    change_column :laws, :content, :text
  end
end

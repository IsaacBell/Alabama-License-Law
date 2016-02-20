class CreateSavedlaws < ActiveRecord::Migration
  def change
    create_table :savedlaws do |t|
      t.integer :lawid
      t.integer :userid

      t.timestamps
    end
  end
end

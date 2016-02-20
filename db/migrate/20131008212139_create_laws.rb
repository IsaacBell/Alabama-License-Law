class CreateLaws < ActiveRecord::Migration
  def change
    create_table :laws do |t|
      t.string :legal_id
      t.string :title
      t.string :content
    end
  end
end

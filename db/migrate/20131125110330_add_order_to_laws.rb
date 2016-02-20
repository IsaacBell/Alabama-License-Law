class AddOrderToLaws < ActiveRecord::Migration
  def change
    add_column :laws, :order, :int
  end
end

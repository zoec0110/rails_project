class RenameListOrderToNumber < ActiveRecord::Migration[7.0]
  def change
    rename_column(:lists, :order, :number)
  end
end

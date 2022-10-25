class DeleteStockListIdColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :stocks, :list_id
  end
end

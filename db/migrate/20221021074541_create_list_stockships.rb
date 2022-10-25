class CreateListStockships < ActiveRecord::Migration[7.0]
  def change
    create_table :list_stockships do |t|
      t.integer :list_id
      t.integer :stock_id

      t.timestamps
    end
  end
end

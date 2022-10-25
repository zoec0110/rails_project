class CreateLists < ActiveRecord::Migration[7.0]
  def change
    create_table :lists do |t|
      t.string 'name'
      t.integer 'order'
      t.integer 'user_id'
      t.integer 'stock_id'
      t.timestamps
    end
  end
end

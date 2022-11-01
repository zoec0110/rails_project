class ListStockship < ApplicationRecord
  belongs_to :list
  belongs_to :stock
end

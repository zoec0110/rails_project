class Stock < ApplicationRecord
  has_many :list_stockships
  has_many :lists, through: :list_stockships
end

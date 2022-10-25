class List < ApplicationRecord
  validates_presence_of :name
  belongs_to :user
  has_many :list_stockships
  has_many :stocks, through: :list_stockships

  def add_order
    if List.count.zero?
      list_qty = List.count
      self.number = list_qty + 1
    else
      list_order = List.order(:number).last
      self.number = list_order.number + 1
    end
  end

  def move_up_number
    last_list = List.where('number < ?', number).order('number asc')
    current_number = number
    self.number = last_list.first.number
    last_list.first.number = current_number
    save
    last_list.first.save
  end

  def move_down_number
    List.where('number > ?', number).order('number asc')
    next_list = List.where('number > ?', number).order('number asc')
    current_number = number
    self.number = next_list.first.number
    next_list.first.number = current_number
    save
    next_list.first.save
  end
end

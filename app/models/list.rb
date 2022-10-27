class List < ApplicationRecord
  validates_presence_of :name
  before_create :add_order
  belongs_to :user
  has_many :list_stockships
  has_many :stocks, through: :list_stockships

  def move_up_number
    last_list = user.lists.where('number < ?', number).order('number desc')
    current_number = number
    self.number = last_list.first.number
    last_list.first.number = current_number
    save
    last_list.first.save
  end

  def move_down_number
    next_list = user.lists.where('number > ?', number).order('number asc')
    current_number = number
    self.number = next_list.first.number
    next_list.first.number = current_number
    save
    next_list.first.save
  end

  private

    def add_order
      if user.lists.count.zero?
        list_qty = 0
        self.number = list_qty + 1
      else
        list_order = user.lists.maximum(:number)
        self.number = list_order + 1
      end
    end
end

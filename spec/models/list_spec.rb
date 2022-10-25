require 'rails_helper'

RSpec.describe List, type: :model do
  describe '.add_order' do
    before(:each) do
      User.create!(email: 'foobar@example.com', password: '12345678')
    end

    it 'list_count = 0, list_number should be 1' do
      list = List.new
      list.add_order
      expect(list.number).to eq(1)
    end

    it 'list_number should be 6 when last list_number: 5' do
      List.create(name: '清單', number: 5, user_id: 1)
      list = List.create(name: '清單6', user_id: 1)
      list.add_order
      expect(list.number).to eq(6)
    end
  end

  describe '.move_up_number' do
    before(:each) do
      User.create!(email: 'foobar@example.com', password: '12345678')
      List.create(name: '清單一', number: 1, user_id: 1)
    end

    it 'list_number: 2 should move to number: 1' do
      list = List.create!(name: '清單二', number: 2, user_id: 1)
      list.move_up_number
      expect(list.number).to eq(1)
    end

    it 'list_number: 3 should move to number: 1 when list_number: 2 not exit' do
      list = List.create(name: '清單三', number: 3, user_id: 1)
      list.move_up_number
      expect(list.number).to eq(1)
    end
  end

  describe '.move_down_number' do
    before(:each) do
      User.create!(email: 'foobar@example.com', password: '12345678')
      List.create(name: '清單一', number: 1, user_id: 1)
    end
    let(:list) { List.find_by(number: 1) }

    it 'list_number: 1 should move to number: 2' do
      List.create(name: '清單二', number: 2, user_id: 1)
      list.move_down_number
      expect(list.number).to eq(2)
    end

    it 'list_number: 1 should move to number: 3 when list_number: 2 not exit' do
      List.create(name: '清單三', number: 3, user_id: 1)
      list.move_down_number
      expect(list.number).to eq(3)
    end
  end
end

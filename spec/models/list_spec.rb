require 'rails_helper'

RSpec.describe List, type: :model do
  describe '.add_order' do
    before(:each) do
      User.create!(email: 'foobar@example.com', password: '12345678')
    end

    let(:current_user) { User.find_by(email: 'foobar@example.com') }

    it 'list_count = 0, list_number should be 1' do
      list = current_user.lists.create(name: '清單')
      expect(list.number).to eq(1)
    end

    it 'list_number should be 4 when last list_number: 3' do
      current_user.lists.create(name: '清單一')
      current_user.lists.create(name: '清單二')
      current_user.lists.create(name: '清單三')
      list = current_user.lists.create(name: '清單四')
      expect(list.number).to eq(4)
    end
  end

  describe '.move_up_number' do
    before(:each) do
      User.create!(email: 'foobar@example.com', password: '12345678')
      current_user.lists.create(name: '清單一')
    end

    let(:current_user) { User.find_by(email: 'foobar@example.com') }

    it 'list_number: 2 should move to number: 1' do
      list = current_user.lists.create(name: '清單二')
      list.move_up_number
      expect(list.number).to eq(1)
    end

    it 'list_number: 3 should move to number: 1 when list_number: 2 destroyed' do
      list2 = current_user.lists.create(name: '清單二')
      list2.destroy
      list = current_user.lists.create(name: '清單三')
      list.move_up_number
      expect(list.number).to eq(1)
    end
  end

  describe '.move_down_number' do
    before(:each) do
      User.create!(email: 'foobar@example.com', password: '12345678')
      current_user.lists.create(name: '清單一')
    end

    let(:current_user) { User.find_by(email: 'foobar@example.com') }
    let(:list) { current_user.lists.find_by(number: 1) }

    it 'list_number: 1 should move to number: 2' do
      current_user.lists.create(name: '清單二')
      list.move_down_number
      expect(list.number).to eq(2)
    end

    it 'list_number: 1 should move to number: 3 when list_number: 2 destroyed' do
      list2 = current_user.lists.create(name: '清單二')
      current_user.lists.create(name: '清單三')
      list2.destroy
      list.move_down_number
      expect(list.number).to eq(3)
    end
  end
end

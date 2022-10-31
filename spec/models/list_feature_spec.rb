require 'rails_helper'

RSpec.describe List, type: :feature do
  context 'when visit list page' do
    before(:each) do
      visit '/'
      User.create!(email: '111@123', password: '123')
      fill_in_sign_in_form_and_submit
    end

    def fill_in_sign_in_form_and_submit
      within('#new_user') do
        fill_in 'user_email', with: '111@123'
        fill_in 'user_password', with: '123'
      end
      click_button '登入'
    end

    def create_list(list_name)
      visit '/lists/new'
      within('#new_list') do
        fill_in 'list_name', with: list_name
      end
      click_button '建立追蹤清單'
    end

    it 'checks list page' do
      visit '/lists'
      expect(page).to have_content('你還沒有建立股票清單哦！')
      expect(page).to have_selector(:link_or_button, '使用者登出')
      expect(page).to have_selector(:link_or_button, '點我建立新的追蹤清單')
    end

    it 'creates list' do
      create_list("清單一")

      visit '/'
      expect(page).to have_content('清單一')
      expect(page).to have_content('編輯清單名稱')
      expect(page).to have_selector(:link_or_button, '點我增新追蹤股')
      expect(page).to have_selector(:link_or_button, '刪除')
    end

    it 'edits list name' do
      create_list("清單一")

      visit '/lists/1/edit'
      expect(page).to have_selector(:link_or_button, '更新追蹤清單名稱')
      within('#edit_list_1') do
        fill_in 'list_name', with: '新清單'
      end
      click_button '更新追蹤清單名稱'

      visit '/'
      expect(page).to have_content('新清單')
    end

    it 'deletes list' do
      create_list("清單一")
      visit '/'
      click_button '刪除'
      expect(page).not_to have_content('清單一')
    end

    it 'creates stock' do
      create_list("清單一")

      visit '/lists/1/stocks'
      expect(page).to have_content('增新追蹤股於 清單一')
      Stock.create!(name: '台積電', stock_symbol: 2330)

      within('#new_stock') do
        fill_in 'stock_stock_symbol', with: '2330'
      end

      click_button '增新追蹤股'

      visit '/'
      expect(page).to have_content('台積電')
    end

    it 'changes user' do
      visit '/lists'
      click_button '使用者登出'

      visit '/'
      User.create!(email: '222', password: '123')

      within('#new_user') do
        fill_in 'user_email', with: '222'
        fill_in 'user_password', with: '123'
      end
      click_button '登入'

      visit '/lists'
      expect(page).to have_content('你還沒有建立股票清單哦！')
      expect(page).to have_selector(:link_or_button, '使用者登出')
      expect(page).to have_selector(:link_or_button, '點我建立新的追蹤清單')
    end
  end
end

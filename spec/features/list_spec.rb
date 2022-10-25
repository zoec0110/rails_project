require 'rails_helper'

feature 'list', type: :feature do
  before(:each) do
    visit 'users/sign_in'
    User.create!(email: '111@123', password: '123')
  end

  def fill_in_sign_in_and_submit_with
    within('#new_user') do
      fill_in 'user_email', with: '111@123'
      fill_in 'user_password', with: '123'
    end
    click_button '登入'
  end

  def create_list
    within('#new_list') do
      fill_in 'list_name', with: '清單一'
    end
    click_button '建立追蹤清單'
  end

  scenario 'stock list page' do
    fill_in_sign_in_and_submit_with
    visit '/'
    expect(page).to have_content('你還沒有建立股票清單哦！')
    click_button '點我建立新的追蹤清單'
  end

  scenario 'create list' do
    fill_in_sign_in_and_submit_with
    visit '/lists/new'
    create_list

    visit '/'
    expect(page).to have_content('清單一')
    expect(page).to have_content('編輯清單名稱')
    expect(page).to have_selector(:link_or_button, '點我增新追蹤股')
    expect(page).to have_selector(:link_or_button, '刪除')
  end

  scenario 'create stock' do
    fill_in_sign_in_and_submit_with
    visit '/lists/new'
    create_list

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
end

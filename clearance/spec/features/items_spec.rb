require 'rails_helper'

describe 'items' do

  let(:sellable_item) { FactoryGirl.create(:item, status: 'sellable') }
  let(:not_sellable_item) { FactoryGirl.create(:item, status: 'not sellable') }
  let(:sold_item) { FactoryGirl.create(:item, status: 'sold') }
  let(:clearanced_item) { FactoryGirl.create(:item, status: 'clearanced') }

  before(:each) do
    sellable_item
    not_sellable_item
    sold_item
    clearanced_item
  end

  context 'with no filter', type: :feature do

    it 'displays the filter menu' do
      visit items_path
      expect(page).to have_menu_for_items_with_status_filter
      expect(page).to_not have_css('table#items')
    end
  end

  context 'filtered for sellable', type: :feature do

    it 'displays the filter menu' do
      visit items_path(filter: 'sellable')
      expect(page).to have_menu_for_items_with_status_filter
    end

    it 'displays the sellable items' do
      visit items_path(filter: 'sellable')
      expect(page.all('table#items tr').count).to eq (1 + 1) # thead

      within('table#items') do
        expect(page).to have_content(sellable_item.id)
        expect(page).to_not have_content(not_sellable_item.id)
        expect(page).to_not have_content(sold_item.id)
        expect(page).to_not have_content(clearanced_item.id)
      end
    end
  end

  context 'filtered for not sellable', type: :feature do

    it 'displays the filter menu' do
      visit items_path
      expect(page).to have_menu_for_items_with_status_filter
    end

    it 'displays the not sellable items' do
      visit items_path(filter: 'not sellable')
      expect(page.all('table#items tr').count).to eq (1 + 1) # thead

      within('table#items') do
        expect(page).to_not have_content(sellable_item.id)
        expect(page).to have_content(not_sellable_item.id)
        expect(page).to_not have_content(sold_item.id)
        expect(page).to_not have_content(clearanced_item.id)
      end
    end
  end

  context 'filtered for sold', type: :feature do

    it 'displays the filter menu' do
      visit items_path
      expect(page).to have_menu_for_items_with_status_filter
    end

    it 'displays the sold items' do
      visit items_path(filter: 'sold')
      expect(page.all('table#items tr').count).to eq (1 + 1) # thead

      within('table#items') do
        expect(page).to_not have_content(sellable_item.id)
        expect(page).to_not have_content(not_sellable_item.id)
        expect(page).to have_content(sold_item.id)
        expect(page).to_not have_content(clearanced_item.id)
      end
    end
  end

  context 'filtered for clearanced', type: :feature do

    it 'displays the filter menu' do
      visit items_path
      expect(page).to have_menu_for_items_with_status_filter
    end

    it 'displays the clearanced items' do
      visit items_path(filter: 'clearanced')
      expect(page.all('table#items tr').count).to eq (1 + 1) # thead

      within('table#items') do
        expect(page).to_not have_content(sellable_item.id)
        expect(page).to_not have_content(not_sellable_item.id)
        expect(page).to_not have_content(sold_item.id)
        expect(page).to have_content(clearanced_item.id)
      end
    end
  end
end

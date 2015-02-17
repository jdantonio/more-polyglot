require "rails_helper"
require_relative 'clearance_batch_creation_shared'

describe "add new monthly clearance_batch" do

  context 'from csv file' do

    def submit_batch(items)
      file_name = generate_csv_file(items)
      attach_file("Select batch file", file_name)
      click_button "upload batch file"
    end

    it_should_behave_like :clearance_batch_creator
  end

  #NOTE: These tests won't work because the test runner isn't setup for JavaScript
  #context 'by scanning barcodes' do

    #def submit_batch(items)
      #generate_item_id_list(items).split(',').each do |id|
        #fill_in 'Enter item number', with: id
        #click_button 'add item'
      #end

      #click_button 'submit batch'
    #end

    #it_should_behave_like :clearance_batch_creator
  #end

  #NOTE: These tests work if the partial _manual_item_entry is substituted
  # for _scan_item_ids
  #context 'with manual entry' do

    #def submit_batch(items)
      #fill_in 'Enter item numbers', with: generate_item_id_list(items)
      #click_button 'submit batch'
    #end

    #it_should_behave_like :clearance_batch_creator
  #end

  describe 'clearance_batches #show', type: :feature do

    let(:clearance_batch) { FactoryGirl.create(:populated_clearance_batch) }

    it 'shows the contents of the batch' do
      items = clearance_batch.items
      styles = items.collect{|item| item.style }.uniq

      visit clearance_batch_path(clearance_batch.id)
      expect(page).to have_content("Clearance Batch #{clearance_batch.id}")
      expect(page.all('table#clearance-batch tr').count).to eq (items.length + 1) # thead

      within('table#clearance-batch') do
        styles.each do |style|
          expect(page).to have_content(style.name)
        end
        items.each do |item|
          expect(page).to have_content(item.size)
          expect(page).to have_content(item.color)
          expect(page).to have_content(item.pretty_print_price_sold)
          expect(page).to have_content(item.sold_at.to_formatted_s(:short))
        end
      end
    end
  end

  describe "clearance_batches index", type: :feature do

    describe "see previous clearance batches" do

      let!(:clearance_batch_1) { FactoryGirl.create(:clearance_batch) }
      let!(:clearance_batch_2) { FactoryGirl.create(:clearance_batch) }

      it "displays a list of all past clearance batches" do
        visit "/"
        expect(page).to have_content(" Clearance Tool")
        expect(page).to have_content("Clearance Batches")
        within('table.clearance_batches') do
          expect(page).to have_content("Clearance Batch #{clearance_batch_1.id}")
          expect(page).to have_content("Clearance Batch #{clearance_batch_2.id}")
        end
      end

    end

    #describe "add a new clearance batch" do

    #context "total success" do

    #it "should allow a user to upload a new clearance batch successfully" do
    #items = 5.times.map{ FactoryGirl.create(:item) }
    #file_name = generate_csv_file(items)
    #visit "/"
    #within('table.clearance_batches') do
    #expect(page).not_to have_content(/Clearance Batch \d+/)
    #end
    #attach_file("Select batch file", file_name)
    #click_button "upload batch file"
    #new_batch = ClearanceBatch.first
    #expect(page).to have_content("#{items.count} items clearanced in batch #{new_batch.id}")
    #expect(page).not_to have_content("item ids raised errors and were not clearanced")
    #within('table.clearance_batches') do
    #expect(page).to have_content(/Clearance Batch \d+/)
    #end
    #end

    #end

    #context "partial success" do

    #it "should allow a user to upload a new clearance batch partially successfully, and report on errors" do
    #valid_items   = 3.times.map{ FactoryGirl.create(:item) }
    #invalid_items = [[987654], ['no thanks']]
    #file_name     = generate_csv_file(valid_items + invalid_items)
    #visit "/"
    #within('table.clearance_batches') do
    #expect(page).not_to have_content(/Clearance Batch \d+/)
    #end
    #attach_file("Select batch file", file_name)
    #click_button "upload batch file"
    #new_batch = ClearanceBatch.first
    #expect(page).to have_content("#{valid_items.count} items clearanced in batch #{new_batch.id}")
    #expect(page).to have_content("#{invalid_items.count} item ids raised errors and were not clearanced")
    #within('table.clearance_batches') do
    #expect(page).to have_content(/Clearance Batch \d+/)
    #end
    #end

    #end

    #context "total failure" do

    #it "should allow a user to upload a new clearance batch that totally fails to be clearanced" do
    #invalid_items = [[987654], ['no thanks']]
    #file_name     = generate_csv_file(invalid_items)
    #visit "/"
    #within('table.clearance_batches') do
    #expect(page).not_to have_content(/Clearance Batch \d+/)
    #end
    #attach_file("Select batch file", file_name)
    #click_button "upload batch file"
    #expect(page).not_to have_content("items clearanced in batch")
    #expect(page).to have_content("No new clearance batch was added")
    #expect(page).to have_content("#{invalid_items.count} item ids raised errors and were not clearanced")
    #within('table.clearance_batches') do
    #expect(page).not_to have_content(/Clearance Batch \d+/)
    #end
    #end
    #end
    #end
  end
end


require 'rails_helper'

describe Item do

  context 'validates' do

    let(:item_attributes) { FactoryGirl.attributes_for(:item) }

    context 'size' do

      it 'is required' do
        item_attributes.delete(:size)
        item = Item.new(item_attributes)
        expect(item).to_not be_valid
      end
    end

    context 'color' do

      it 'is required' do
        item_attributes.delete(:color)
        item = Item.new(item_attributes)
        expect(item).to_not be_valid
      end
    end

    context 'status' do

      it 'is required' do
        item_attributes.delete(:status)
        item = Item.new(item_attributes)
        expect(item).to_not be_valid
      end

      it 'must be one of the pre-defined values' do
        item = Item.new(item_attributes)
        Item::STATUSES.each do |status|
          item.status = status
          expect(item).to be_valid
        end

        item.status = 'crazy bogus invalid status'
        expect(item).to_not be_valid
      end
    end

    context 'price_sold' do

      it 'cannot be zero' do
        item = Item.new(item_attributes.merge(price_sold: 0))
        expect(item).to_not be_valid
      end

      it 'cannot be less than zero' do
        item = Item.new(item_attributes.merge(price_sold: -1))
        expect(item).to_not be_valid
      end
    end

    context 'price_sold_cents' do

      it 'is nil when #price_sold is unset' do
        item = FactoryGirl.build(:item)
        item.price_sold = nil
        expect(item.price_sold_cents).to be_nil
      end

      it 'is equal to #price_sold * 10 when #price_sold is set' do
        item = FactoryGirl.build(:sold_item, price_sold: 12345.67)
        expect(item.price_sold_cents).to eq 1234567
      end

      it 'sets #price_sold to the dollar value when changed' do
        item = FactoryGirl.build(:item)
        item.price_sold_cents = 1234567
        expect(item.price_sold).to be_within(0.000001).of(12345.67)
      end
    end

    context 'sold attributes' do

      specify 'price_sold cannot be set when sold_at is unset' do
        item = FactoryGirl.build(:sold_item)
        item.sold_at = nil
        expect(item).to_not be_valid
      end

      specify 'sold_at cannot be set when price_sold is unset' do
        item = FactoryGirl.build(:sold_item)
        item.sold_at = nil
        expect(item).to_not be_valid
      end
    end
  end

  describe "clearance!" do

    let(:wholesale_price) { 100 }
    let(:item) { FactoryGirl.create(:item, style: FactoryGirl.create(:style, wholesale_price: wholesale_price)) }
    let(:sold_time) { Time.now }

    before(:each) do
      Timecop.freeze(sold_time)
      item.clearance!
      item.reload
    end

    after(:each) do
      Timecop.return
    end

    context 'basic item' do

      it "should mark the item status as clearanced" do
        expect(item.status).to eq("clearanced")
      end

      it "adjusts the price_sold based on the discount value and the wholesale_price" do
        expect(item.price_sold).to eq(wholesale_price * Item::CLEARANCE_PRICE_PERCENTAGE)
      end

      it 'sets #sold_at to the current date/time' do
        expect(item.sold_at).to eq(sold_time)
      end
    end

    context 'when discount is below minimum value' do

      it 'sets the value to the default minimum value' do
        style = FactoryGirl.create(:style,
                                   wholesale_price_cents: Item::DEFAULT_MINIMUM_PRICE_CENTS + 1,
                                   minimum_price_cents: nil)
        item = FactoryGirl.create(:item, style: style)
        
        item.clearance!
        expect(item.price_sold_cents).to eq (Item::DEFAULT_MINIMUM_PRICE_CENTS)
      end

      it 'sets the value to the specified minimum value' do
        style = FactoryGirl.create(:style,
                                   wholesale_price: 10.0,
                                   minimum_price: 9.0)
        item = FactoryGirl.create(:item, style: style)
        
        item.clearance!
        expect(item.price_sold_cents).to eq (900)
      end
    end
  end
end

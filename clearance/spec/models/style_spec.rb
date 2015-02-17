require 'rails_helper'

describe Style do

  context 'validates' do

    let(:style_attributes) { FactoryGirl.attributes_for(:style) }

    context 'wholesale_price' do

      it 'is required' do
        style_attributes.delete(:wholesale_price)
        style = Style.new(style_attributes)
        expect(style).to_not be_valid
      end

      it 'cannot be zero' do
        style = Style.new(style_attributes.merge(wholesale_price: 0))
        expect(style).to_not be_valid
      end

      it 'cannot be less than zero' do
        style = Style.new(style_attributes.merge(wholesale_price: -1))
        expect(style).to_not be_valid
      end
    end

    context 'retail_price' do

      it 'is required' do
        style_attributes.delete(:retail_price)
        style = Style.new(style_attributes)
        expect(style).to_not be_valid
      end

      it 'cannot be zero' do
        style = Style.new(style_attributes.merge(retail_price: 0))
        expect(style).to_not be_valid
      end

      it 'cannot be less than zero' do
        style = Style.new(style_attributes.merge(retail_price: -1))
        expect(style).to_not be_valid
      end
    end

    context 'minimum_price' do

      it 'may be nil' do
        style_attributes.delete(:minimum_price)
        style = Style.new(style_attributes)
        expect(style).to be_valid
      end

      it 'cannot be zero' do
        style = Style.new(style_attributes.merge(minimum_price: 0))
        expect(style).to_not be_valid
      end

      it 'cannot be less than zero' do
        style = Style.new(style_attributes.merge(minimum_price: -1))
        expect(style).to_not be_valid
      end
    end

    context 'wholesale_price_cents' do

      it 'is nil when #wholesale_price is unset' do
        style = FactoryGirl.build(:style)
        style.wholesale_price = nil
        expect(style.wholesale_price_cents).to be_nil
      end

      it 'is equal to #wholesale_price * 10 when #wholesale_price is set' do
        style = FactoryGirl.build(:style, wholesale_price: 12345.67)
        expect(style.wholesale_price_cents).to eq 1234567
      end

      it 'sets #wholesale_price to the dollar value when changed' do
        style = FactoryGirl.build(:style)
        style.wholesale_price_cents = 1234567
        expect(style.wholesale_price).to be_within(0.000001).of(12345.67)
      end
    end

    context 'retail_price_cents' do

      it 'is nil when #retail_price is unset' do
        style = FactoryGirl.build(:style)
        style.retail_price = nil
        expect(style.retail_price_cents).to be_nil
      end

      it 'is equal to #retail_price * 10 when #retail_price is set' do
        style = FactoryGirl.build(:style, retail_price: 12345.67)
        expect(style.retail_price_cents).to eq 1234567
      end

      it 'sets #retail_price to the dollar value when changed' do
        style = FactoryGirl.build(:style)
        style.retail_price_cents = 1234567
        expect(style.retail_price).to be_within(0.000001).of(12345.67)
      end
    end

    context 'minimum_price_cents' do

      it 'is nil when #minimum_price is unset' do
        style = FactoryGirl.build(:style)
        style.minimum_price = nil
        expect(style.minimum_price_cents).to be_nil
      end

      it 'is equal to #minimum_price * 10 when #minimum_price is set' do
        style = FactoryGirl.build(:style, minimum_price: 12345.67)
        expect(style.minimum_price_cents).to eq 1234567
      end

      it 'sets #minimum_price to the dollar value when changed' do
        style = FactoryGirl.build(:style)
        style.minimum_price_cents = 1234567
        expect(style.minimum_price).to be_within(0.000001).of(12345.67)
      end
    end

    context 'type' do

      it 'is required' do
        style_attributes.delete(:type)
        style = Style.new(style_attributes)
        expect(style).to_not be_valid
      end
    end

    context 'name' do

      it 'is required' do
        style_attributes.delete(:name)
        style = Style.new(style_attributes)
        expect(style).to_not be_valid
      end
    end
  end
end

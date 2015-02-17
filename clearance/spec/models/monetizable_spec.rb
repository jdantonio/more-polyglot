require_relative '../../app/models/monetizable'

describe Monetizable do

  subject do
    Class.new{
      include Monetizable
    }.new
  end

  context '#dollars_to_cents' do

    it 'returns nil when given nil' do
      actual = subject.dollars_to_cents(nil)
      expect(actual).to be_nil
    end

    it 'returns the correct number of cents as int when given a float' do
      actual = subject.dollars_to_cents(1234.56)
      expect(actual).to be_a Fixnum
      expect(actual).to eq 123456
    end

    it 'rounds up to the nearest cent when given extra precision' do
      actual = subject.dollars_to_cents(1234.5601)
      expect(actual).to be_a Fixnum
      expect(actual).to eq 123457
    end
  end

  context '#cents_to_dollars' do

    it 'returns nil when given nil' do
      actual = subject.cents_to_dollars(nil)
      expect(actual).to be_nil
    end

    it 'returns the correct number of dollars when given cents' do
      actual = subject.cents_to_dollars(123456)
      expect(actual).to be_a Float
      expect(actual).to be_within(0.001).of(1234.56)
    end

    it 'rounds to the nearest cent when given extra precision' do
      actual = subject.cents_to_dollars(123456.1)
      expect(actual).to be_a Float
      expect(actual).to be_within(0.001).of(1234.57)
    end
  end

  context '#pretty_print_cents' do

    it 'returns 0.00 when given nil' do
      actual = subject.pretty_print_cents(nil)
      expect(actual).to eq '0.00'
    end

    it 'returns the correct number of dollars when given cents' do
      actual = subject.pretty_print_cents(123456)
      expect(actual).to eq '1234.56'
    end

    it 'rounds to the nearest cent when given extra precision' do
      actual = subject.pretty_print_cents(123456.1)
      expect(actual).to eq '1234.57'
    end
  end

  context 'dollar_attribute_for' do

    let!(:cents_value){ 10000 }
    let!(:dollar_value){ 100.00 }

    let(:money_class) do
      Class.new {
        include Monetizable
        attr_accessor :foo_cents
        attr_accessor :bar_cents
        def read_attribute(attr)
          instance_variable_get("@#{attr}")
        end
        def write_attribute(attr, value)
          instance_variable_set("@#{attr}", value)
        end
      }
    end

    it 'raises an exception when no arguments are given' do
      expect {
        money_class.dollar_attribute_for
      }.to raise_error(ArgumentError)
    end

    it 'defines a setter for an attribute ending in "_cents"' do
      money_class.dollar_attribute_for(:foo_cents)
      subject = money_class.new
      subject.foo = dollar_value
      expect(subject.foo_cents).to eq cents_value
    end

    it 'defines a setter for an attribute not ending in "_cents"' do
      money_class.dollar_attribute_for(:foo)
      subject = money_class.new
      subject.foo = dollar_value
      expect(subject.foo_cents).to eq cents_value
    end

    it 'defines a getter for an attribute ending in "_cents"' do
      money_class.dollar_attribute_for(:foo_cents)
      subject = money_class.new
      subject.foo_cents = cents_value
      expect(subject.foo).to be_within(0.00001).of(dollar_value)
    end

    it 'defines a getter for an attribute not ending in "_cents"' do
      money_class.dollar_attribute_for(:foo)
      subject = money_class.new
      subject.foo_cents = cents_value
      expect(subject.foo).to be_within(0.00001).of(dollar_value)
    end

    it 'accepts multiple attributes on a single call' do
      money_class.dollar_attribute_for(:foo, :bar_cents)
      subject = money_class.new
      expect(subject).to respond_to(:foo=)
      expect(subject).to respond_to(:bar=)
    end
  end
end

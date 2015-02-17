module Monetizable

  def dollars_to_cents(dollars)
    if dollars.nil?
      nil
    else
      (dollars * 100.0).ceil
    end
  end

  def cents_to_dollars(cents)
    if cents.nil?
      nil
    else
      cents.ceil / 100.0
    end
  end

  def pretty_print_cents(cents)
    sprintf("%.2f", cents_to_dollars(cents.nil? ? 0 : cents))
  end

  def self.included(base)

    class << base

      def dollar_attribute_for(*args)
        raise ArgumentError.new('wrong number of arguments (0 for 1+)') if args.empty?

        args.each do |attr|
          attr = attr.to_s.gsub(/_cents$/, '')

          define_method(attr) do
            cents_to_dollars(read_attribute("#{attr}_cents"))
          end

          define_method("#{attr}=") do |dollars|
            cents = dollars_to_cents(dollars)
            write_attribute("#{attr}_cents", cents)
            cents
          end

          define_method("pretty_print_#{attr}") do
            pretty_print_cents(read_attribute("#{attr}_cents"))
          end
        end
      end
    end
  end
end

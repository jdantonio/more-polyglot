class Item < ActiveRecord::Base
  include Monetizable

  CLEARANCE_PRICE_PERCENTAGE = 0.75
  DEFAULT_MINIMUM_PRICE_CENTS = 200

  STATUSES = [
    'sellable',
    'not sellable',
    'sold',
    'clearanced'
  ]

  belongs_to :style
  belongs_to :clearance_batch

  dollar_attribute_for :price_sold_cents

  validates :size, :color, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :price_sold_cents, numericality: { greater_than: 0 }, allow_blank: true

  validate :all_sold_attributes_are_set_together

  scope :sellable, -> { where(status: 'sellable') }

  def sellable?
    read_attribute(:status) == 'sellable'
  end

  def clearance!
    update_attributes!(status: 'clearanced', 
                       price_sold_cents: calculate_clearance_price,
                       sold_at: Time.now)
  end

  def all_sold_attributes_are_set_together
    message = 'must be set when the item is sold'
    if price_sold_cents.present? && !sold_at.present?
      errors.add(:sold_at, message)
    elsif !price_sold_cents.present? && sold_at.present?
      errors.add(:price_sold_cents, message)
    end
  end

  private

  def calculate_clearance_price
    min_price = style.minimum_price_cents || DEFAULT_MINIMUM_PRICE_CENTS
    price = style.wholesale_price_cents * CLEARANCE_PRICE_PERCENTAGE
    price = min_price if price < min_price
    price
  end
end

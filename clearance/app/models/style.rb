class Style < ActiveRecord::Base
  include Monetizable

  self.inheritance_column = :_type_disabled
  has_many :items

  dollar_attribute_for :wholesale_price_cents,
                       :retail_price_cents,
                       :minimum_price_cents

  validates :type, :name, presence: true
  validates :wholesale_price_cents, :retail_price_cents, numericality: { greater_than: 0 }
  validates :minimum_price_cents, numericality: { greater_than: 0 }, allow_blank: true
end

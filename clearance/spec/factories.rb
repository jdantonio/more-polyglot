require 'faker'

FactoryGirl.define do

  factory :clearance_batch do
  end

  factory :populated_clearance_batch, parent: :clearance_batch do
    after(:build) do |batch|
      3.times do
        style = FactoryGirl.create(:random_style)
        5.times do
          batch.items << FactoryGirl.create(:random_sold_item, style: style)
        end
      end
    end
  end

  factory :item do
    style
    color "Blue"
    size "M"
    status "sellable"
  end

  factory :sold_item, parent: :item do
    price_sold 100
    sold_at { 1.week.ago }
  end

  factory :random_style, parent: :style do
    name { Faker::Commerce.product_name }
    type { Faker::Lorem.word }
    wholesale_price { 20 + rand(30) }
    retail_price { 5 + rand(10) }
  end

  factory :random_sold_item, parent: :sold_item do
    style { FactoryGirl.create(:random_style) }
    color { Faker::Commerce.color }
    size { ['XXXS', 'XXS', 'XS', 'S', 'M', 'L', 'XL', 'XXL'].sample }
  end

  factory :style do
    name "Abrianna Lightweight Knit Cardigan"
    type "Sweater"
    wholesale_price 55
    retail_price 200
    minimum_price 2
  end
end

class PricesToCentsInStyle < ActiveRecord::Migration

  #NOTE: This would never work in production. We would need to do one
  # migration that added the new column then run a rake task to migrate
  # the old column. Once we verified the new data we would drop the old
  # column. Of course, we would also do a bunch of backups along the
  # way. For the purpose of this exercise I'm taking the easy route.

  def up
    add_column :styles, :wholesale_price_cents, :integer, null: true
    add_column :styles, :retail_price_cents, :integer, null: true
    remove_column :styles, :wholesale_price
    remove_column :styles, :retail_price
  end

  def down
    add_column :styles, :wholesale_price, :decimal
    add_column :styles, :retail_price, :decimal
    remove_column :styles, :wholesale_price_cents
    remove_column :styles, :retail_price_cents
  end
end

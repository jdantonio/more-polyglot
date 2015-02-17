class AddMinimumPriceToStyle < ActiveRecord::Migration

  #NOTE: In production we may want to add a rake task to set the initial values
  # of the new column. For the purpose of this exercise I'm taking the easy
  # route and just updating the seed data. I've added a 'default minimum'
  # check in the model that is hardcoded which would protect any data that
  # didn't get the necessary update.

  def up
    add_column :styles, :minimum_price_cents, :integer, null: true, default: 200
  end

  def down
    remove_column :styles, :minimum_price_cents
  end
end

require 'csv'

class ClearancingService

  ClearancingStatus = Struct.new(:clearance_batch, :items_to_clearance, :errors) do
    def initialize
      self.clearance_batch = ClearanceBatch.new
      self.items_to_clearance = []
      self.errors = []
    end

    def clearance_items!
      if items_to_clearance.any? 
        clearance_batch.save!
        items_to_clearance.each do |item|
          item.clearance!
          clearance_batch.items << item
        end
      end
    end
  end

  def initialize(potential_ids)
    @potential_ids = potential_ids
  end

  def self.from_csv_file(file)
    self.new(CSV.read(file, headers: false).collect{|row| row.first })
  end

  def self.from_delimited_string(potential_ids)
    # "1 , 2 , 3,4;5, 6 7   8      9         ;     10"
    potential_ids = potential_ids.to_s.split(/\s+[,;]\s*|\s*[,;]\s+|[,;]|\s+/)
    self.new(potential_ids)
  end

  def process
    clearancing_status = ClearancingStatus.new

    items = Item.includes(:style).where(id: @potential_ids)

    clearancing_status.items_to_clearance, clearancing_status.errors = filter_clearanceable_items(items)
    clearancing_status.errors += get_clearancing_errors(@potential_ids - items.collect{|item| item.id.to_s })

    clearancing_status.clearance_items!
    clearancing_status
  end

  private

  def valid_item_id?(id)
    !id.nil? && id.strip =~ /^\d+$/ && id.to_i > 0
  end

  def filter_clearanceable_items(items)
    filtered = items.reduce([[],[]]) do |memo, item|
      if item.sellable?
        memo.first << item
      else
        memo.last << "Item id #{item.id} could not be clearanced"
      end
      memo
    end

    return filtered.first, filtered.last
  end

  def get_clearancing_errors(unfound_item_ids)
    unfound_item_ids.collect do |id|
      if ! valid_item_id?(id)
        "Item id '#{id}' is not valid"      
      else
        "Item id #{id} could not be found"
      end
    end
  end

  def clearance_items!(clearancing_status)
    if clearancing_status.items_to_clearance.any? 
      clearancing_status.clearance_batch.save!
      clearancing_status.items_to_clearance.each do |item|
        item.clearance!
        clearancing_status.clearance_batch.items << item
      end
    end
    clearancing_status
  end
end

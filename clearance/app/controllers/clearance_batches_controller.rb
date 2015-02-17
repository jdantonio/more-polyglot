class ClearanceBatchesController < ApplicationController

  def index
    @clearance_batches  = ClearanceBatch.all
  end

  def create
    if params.has_key? :csv_batch_file
      clearancing_service = ClearancingService.from_csv_file(params[:csv_batch_file].tempfile)
    else
      clearancing_service = ClearancingService.from_delimited_string(params[:item_ids])
    end

    clearancing_status = clearancing_service.process
    clearance_batch    = clearancing_status.clearance_batch
    alert_messages     = []
    if clearance_batch.persisted?
      flash[:notice]  = "#{clearance_batch.items.count} items clearanced in batch #{clearance_batch.id}"
    else
      alert_messages << "No new clearance batch was added"
    end
    if clearancing_status.errors.any?
      alert_messages << "#{clearancing_status.errors.count} item ids raised errors and were not clearanced"
      clearancing_status.errors.each {|error| alert_messages << error }
    end
    flash[:alert] = alert_messages.join("<br/>") if alert_messages.any?
    redirect_to action: :index
  end

  def new
  end

  def show
    @clearance_batch = ClearanceBatch.includes(items: [:style]).find(params[:id])
  end
end

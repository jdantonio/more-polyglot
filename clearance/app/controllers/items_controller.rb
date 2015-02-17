class ItemsController < ApplicationController

  def index
    filter = params[:filter]
    @statuses = Item::STATUSES
    if filter
      @items = Item.includes(:style).where(status: filter)
    end
  end

  def show
    # the route should prevent non-xhr requests from getting here
    if request.xhr?
      item = Item.includes(:style).find(params[:item_id])
      render json: item.to_json(:include => [:style])
    end
  end
end

Rails.application.routes.draw do

  class OnlyAjaxRequest
    def matches?(request)
      request.xhr?
    end
  end

  resources :clearance_batches, only: [:index, :create, :show, :new]

  resources :items, only: [:index] do
    get '' => 'items#show', constraint: OnlyAjaxRequest.new   
  end

  root to: "clearance_batches#index"
end

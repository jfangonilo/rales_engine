class Api::V1::InvoiceItemsController < ApplicationController
  def index
    if params[:item_id]
      render json: InvoiceItemSerializer.new(InvoiceItem.from_item(params[:item_id]))
    end
  end
end
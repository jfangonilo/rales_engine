class Api::V1::ItemsController < ApplicationController
  def index
    if params[:merchant_id]
      render json: ItemSerializer.new(Merchant.find(params[:merchant_id]).items)
    else
      render json: ItemSerializer.new(Item.all)
    end
  end
end
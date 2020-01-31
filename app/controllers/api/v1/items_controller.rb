class Api::V1::ItemsController < ApplicationController
  def index
    if params[:merchant_id]
      render json: ItemSerializer.new(Item.from_merchant(params[:merchant_id]))
    else
      render json: ItemSerializer.new(Item.all)
    end
  end

  def show
    if params[:id]
      render json: ItemSerializer.new(Item.find(params[:id]))
    elsif params[:name]
      render json: ItemSerializer.new(Item.find_by(name: params[:name]))
    end
  end
end
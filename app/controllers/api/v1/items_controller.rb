class Api::V1::ItemsController < ApplicationController
  def index
    index = Item.search_all(params)
    render json: ItemSerializer.new(index)
  end

  def show
    item = Item.search(params)
    render json: ItemSerializer.new(item)
  end
end
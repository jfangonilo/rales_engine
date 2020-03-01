class Api::V1::ItemsController < ApplicationController
  def index
    items = Item.search_all(params)
    render json: ItemSerializer.new(items)
  end

  def show
    item = Item.search(params)
    render json: ItemSerializer.new(item)
  end
end

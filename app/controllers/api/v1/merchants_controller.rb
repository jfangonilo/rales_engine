class Api::V1::MerchantsController < ApplicationController
  def index
    index = Merchant.search_all(params)
    render json: MerchantSerializer.new(index)
  end

  def show
    merchant = Merchant.search(params)
    render json: MerchantSerializer.new(merchant)
  end
end
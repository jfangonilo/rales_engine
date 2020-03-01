class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.search_all(params)
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = Merchant.search(params)
    render json: MerchantSerializer.new(merchant)
  end
end

class Api::V1::FavoriteMerchantController < ApplicationController
  def show
    merchant = Merchant.favorite_by_customer(params[:customer_id])
    render json: FavoriteMerchantSerializer.new(merchant)
  end
end
module Api
  module V1
    class FavoriteMerchantController < ApplicationController
      def show
        merchant = Merchant.favorite_by_customer(params[:customer_id])
        render json: FavoriteMerchantSerializer.new(merchant)
      end
    end
  end
end

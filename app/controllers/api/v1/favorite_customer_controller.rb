module Api
  module V1
    class FavoriteCustomerController < ApplicationController
      def show
        customer = Customer.favorite_by_merchant(params[:merchant_id])
        render json: FavoriteCustomerSerializer.new(customer)
      end
    end
  end
end

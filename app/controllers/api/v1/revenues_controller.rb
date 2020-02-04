module Api
  module V1
    class RevenuesController < ApplicationController
      def index
        merchants = Merchant.most_revenue(params[:quantity])
        render json: MerchantSerializer.new(merchants)
      end

      def show
        revenue = Merchant.total_revenue_by_date(params[:date])
        render json: RevenueSerializer.new(revenue)
      end
    end
  end
end

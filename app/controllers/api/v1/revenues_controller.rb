class Api::V1::RevenuesController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.most_revenue(params[:quantity]))
  end

  def show
    render json: RevenueSerializer.new(Merchant.total_revenue(params[:date]))
  end
end
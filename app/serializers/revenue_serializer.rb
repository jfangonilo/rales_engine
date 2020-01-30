class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :total_revenue do |merchant|
    merchant.total_revenue.to_s
  end
end

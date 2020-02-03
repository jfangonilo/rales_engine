require 'rails_helper'

describe "Transactions API" do
  it "sends a list of transactions" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    create_list(:transaction, 3, invoice: invoice)

    get  "/api/v1/transactions"
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result.count).to eq 3
  end

  it "can get a single transaction" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    transaction = create(:transaction, invoice: invoice)

    get "/api/v1/transactions/#{transaction.id}"
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result["attributes"]["id"]).to eq transaction.id
  end
end
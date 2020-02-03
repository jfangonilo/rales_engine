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

  it "can find a single transaction by id" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    transaction = create(:transaction, invoice: invoice)

    get "/api/v1/transactions/find?id=#{transaction.id}"
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result["attributes"]["id"]).to eq transaction.id
  end

  it "can find a single transaction by invoice_id" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    transaction = create(:transaction, invoice: invoice)

    get "/api/v1/transactions/find?invoice_id=#{transaction.invoice_id}"
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result["attributes"]["id"]).to eq transaction.id
  end

  it "can find a single transaction by invoice_id" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    transaction = create(:transaction, invoice: invoice)

    get "/api/v1/transactions/find?invoice_id=#{transaction.invoice_id}"
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result["attributes"]["id"]).to eq transaction.id
  end

  it "can find a single transaction by credit_card_number" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    transaction = create(:transaction, invoice: invoice)

    get "/api/v1/transactions/find?credit_card_number=#{transaction.credit_card_number}"
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result["attributes"]["id"]).to eq transaction.id
  end

  it "can find a single transaction by result" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    transaction = create(:transaction, invoice: invoice)

    get "/api/v1/transactions/find?result=#{transaction.result}"
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result["attributes"]["id"]).to eq transaction.id
  end

  it "can find a single transaction by created_at" do
    date = "2012-01-01"
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    transaction = create(:transaction, invoice: invoice, created_at: date)

    get "/api/v1/transactions/find?created_at=#{transaction.created_at}"
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result["attributes"]["id"]).to eq transaction.id
  end

  it "can find a single transaction by updated_at" do
    date = "2012-01-01"
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    transaction = create(:transaction, invoice: invoice, updated_at: date)

    get "/api/v1/transactions/find?updated_at=#{transaction.updated_at}"
    expect(response).to be_successful
    result = JSON.parse(response.body)["data"]
    expect(result["attributes"]["id"]).to eq transaction.id
  end
end
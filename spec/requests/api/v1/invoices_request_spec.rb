require 'rails_helper'

describe "Invoices API" do
  it "can send a list of invoices" do
    customer = create(:customer)
    merchant = create(:merchant)
    create_list(:invoice, 3, customer: customer, merchant: merchant)

    get "/api/v1/invoices"

    expect(response).to be_successful
    parsed_invoices = JSON.parse(response.body)["data"]
    expect(parsed_invoices.count).to eq 3
  end

  it "can show an invoice" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)

    get "/api/v1/invoices/#{invoice.id}"
    expect(response).to be_successful
    parsed_invoice = JSON.parse(response.body)["data"]
    expect(parsed_invoice["attributes"]["id"]).to eq invoice.id
  end

  it "can find a single invoice by id" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)

    get "/api/v1/invoices/find?id=#{invoice.id}"
    expect(response).to be_successful
    parsed_invoice = JSON.parse(response.body)["data"]
    expect(parsed_invoice["attributes"]["id"]).to eq invoice.id
  end

  it "can find a single invoice by customer_id" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)

    get "/api/v1/invoices/find?customer_id=#{invoice.customer_id}"
    expect(response).to be_successful
    parsed_invoice = JSON.parse(response.body)["data"]
    expect(parsed_invoice["attributes"]["id"]).to eq invoice.id
  end

  it "can find a single invoice by merchant_id" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)

    get "/api/v1/invoices/find?merchant_id=#{invoice.merchant_id}"
    expect(response).to be_successful
    parsed_invoice = JSON.parse(response.body)["data"]
    expect(parsed_invoice["attributes"]["id"]).to eq invoice.id
  end

  it "can find a single invoice by status" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)

    get "/api/v1/invoices/find?status=#{invoice.status}"
    expect(response).to be_successful
    parsed_invoice = JSON.parse(response.body)["data"]
    expect(parsed_invoice["attributes"]["id"]).to eq invoice.id
  end

  it "can find a single invoice by created_at" do
    date = "2012-01-01"
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant, created_at: date)

    get "/api/v1/invoices/find?created_at=#{invoice.created_at}"
    expect(response).to be_successful
    parsed_invoice = JSON.parse(response.body)["data"]
    expect(parsed_invoice["attributes"]["id"]).to eq invoice.id
  end

  it "can find a single invoice by updated_at" do
    date = "2012-01-01"
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant, updated_at: date)

    get "/api/v1/invoices/find?updated_at=#{invoice.updated_at}"
    expect(response).to be_successful
    parsed_invoice = JSON.parse(response.body)["data"]
    expect(parsed_invoice["attributes"]["id"]).to eq invoice.id
  end
end
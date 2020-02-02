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

  it "can get all invoices with id" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_2 = create(:invoice, customer: customer, merchant: merchant)

    get "/api/v1/invoices/find_all?id=#{invoice.id}"
    expect(response).to be_successful
    parsed_invoices = JSON.parse(response.body)["data"]
    expect(parsed_invoices.first["attributes"]["id"]).to eq invoice.id
  end

  it "can get all invoices with customer_id" do
    customer = create(:customer)
    customer_2 = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_2 = create(:invoice, customer: customer_2, merchant: merchant)
    invoice_3 = create(:invoice, customer: customer, merchant: merchant)

    get "/api/v1/invoices/find_all?customer_id=#{invoice.customer_id}"
    expect(response).to be_successful
    parsed_invoices = JSON.parse(response.body)["data"]
    expect(parsed_invoices.count).to eq 2
    expect(parsed_invoices.first["attributes"]["id"]).to eq invoice.id
    expect(parsed_invoices.last["attributes"]["id"]).to eq invoice_3.id
  end

  it "can get all invoices with merchant_id" do
    customer = create(:customer)
    merchant = create(:merchant)
    merchant_2 = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_2 = create(:invoice, customer: customer, merchant: merchant_2)
    invoice_3 = create(:invoice, customer: customer, merchant: merchant)

    get "/api/v1/invoices/find_all?merchant_id=#{invoice.merchant_id}"
    expect(response).to be_successful
    parsed_invoices = JSON.parse(response.body)["data"]
    expect(parsed_invoices.count).to eq 2
    expect(parsed_invoices.first["attributes"]["id"]).to eq invoice.id
    expect(parsed_invoices.last["attributes"]["id"]).to eq invoice_3.id
  end

  it "can get all invoices with status" do
    customer = create(:customer)
    merchant = create(:merchant)
    merchant_2 = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_2 = create(:invoice, customer: customer, merchant: merchant_2)
    invoice_3 = create(:invoice, customer: customer, merchant: merchant)
    invoice_4 = create(:invoice, customer: customer, merchant: merchant, status: "failed")

    get "/api/v1/invoices/find_all?status=#{invoice.status}"
    expect(response).to be_successful
    parsed_invoices = JSON.parse(response.body)["data"]
    expect(parsed_invoices.count).to eq 3
    expect(parsed_invoices.first["attributes"]["id"]).to eq invoice.id
    expect(parsed_invoices.last["attributes"]["id"]).to eq invoice_3.id
  end

  it "can get all invoices with created_at" do
    date = "2012-01-01"
    customer = create(:customer)
    merchant = create(:merchant)
    merchant_2 = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant, created_at: date)
    invoice_2 = create(:invoice, customer: customer, merchant: merchant_2, created_at: date)
    invoice_3 = create(:invoice, customer: customer, merchant: merchant, created_at: date)
    invoice_4 = create(:invoice, customer: customer, merchant: merchant)

    get "/api/v1/invoices/find_all?created_at=#{invoice.created_at}"
    expect(response).to be_successful
    parsed_invoices = JSON.parse(response.body)["data"]
    expect(parsed_invoices.count).to eq 3
    expect(parsed_invoices.first["attributes"]["id"]).to eq invoice.id
    expect(parsed_invoices.last["attributes"]["id"]).to eq invoice_3.id
  end

  it "can get all invoices with updated_at" do
    date = "2012-01-01"
    customer = create(:customer)
    merchant = create(:merchant)
    merchant_2 = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant, updated_at: date)
    invoice_2 = create(:invoice, customer: customer, merchant: merchant_2, updated_at: date)
    invoice_3 = create(:invoice, customer: customer, merchant: merchant, updated_at: date)
    invoice_4 = create(:invoice, customer: customer, merchant: merchant)

    get "/api/v1/invoices/find_all?updated_at=#{invoice.updated_at}"
    expect(response).to be_successful
    parsed_invoices = JSON.parse(response.body)["data"]
    expect(parsed_invoices.count).to eq 3
    expect(parsed_invoices.first["attributes"]["id"]).to eq invoice.id
    expect(parsed_invoices.last["attributes"]["id"]).to eq invoice_3.id
  end
end
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
end
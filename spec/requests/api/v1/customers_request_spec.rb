require 'rails_helper'

describe "Customers API" do
  it "sends a list of customers" do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful
    parsed_customers = JSON.parse(response.body)["data"]
    expect(parsed_customers.count).to eq 3
  end

  it "can show a customer" do
    customer = create(:customer)

    get "/api/v1/customers/#{customer.id}"

    expect(response).to be_successful
    parsed_customer = JSON.parse(response.body)["data"]
    expect(parsed_customer["attributes"]["id"]).to eq customer.id
    expect(parsed_customer["attributes"]["first_name"]).to eq customer.first_name
    expect(parsed_customer["attributes"]["last_name"]).to eq customer.last_name
  end

  it "can get a single customer by id" do
    customer = create(:customer)

    get "/api/v1/customers/find?id=#{customer.id}"
    expect(response).to be_successful
    parsed_customer = JSON.parse(response.body)["data"]
    expect(parsed_customer["attributes"]["id"]).to eq customer.id
    expect(parsed_customer["attributes"]["first_name"]).to eq customer.first_name
    expect(parsed_customer["attributes"]["last_name"]).to eq customer.last_name
  end

  it "can get a single customer by first_name" do
    customer = create(:customer)

    get "/api/v1/customers/find?first_name=#{customer.first_name}"
    expect(response).to be_successful
    parsed_customer = JSON.parse(response.body)["data"]
    expect(parsed_customer["attributes"]["id"]).to eq customer.id
    expect(parsed_customer["attributes"]["first_name"]).to eq customer.first_name
    expect(parsed_customer["attributes"]["last_name"]).to eq customer.last_name
  end

  it "can get a single customer by last_name" do
    customer = create(:customer)

    get "/api/v1/customers/find?last_name=#{customer.last_name}"
    expect(response).to be_successful
    parsed_customer = JSON.parse(response.body)["data"]
    expect(parsed_customer["attributes"]["id"]).to eq customer.id
    expect(parsed_customer["attributes"]["first_name"]).to eq customer.first_name
    expect(parsed_customer["attributes"]["last_name"]).to eq customer.last_name
  end

  it "can get a single customer by created_at" do
    date = "2012-01-01"
    customer = create(:customer, created_at: date)

    get "/api/v1/customers/find?created_at=#{date}"
    expect(response).to be_successful
    parsed_customer = JSON.parse(response.body)["data"]
    expect(parsed_customer["attributes"]["id"]).to eq customer.id
    expect(parsed_customer["attributes"]["first_name"]).to eq customer.first_name
    expect(parsed_customer["attributes"]["last_name"]).to eq customer.last_name
  end

  it "can get a single customer by updated_at" do
    date = "2012-01-01"
    customer = create(:customer, updated_at: date)

    get "/api/v1/customers/find?updated_at=#{date}"
    expect(response).to be_successful
    parsed_customer = JSON.parse(response.body)["data"]
    expect(parsed_customer["attributes"]["id"]).to eq customer.id
    expect(parsed_customer["attributes"]["first_name"]).to eq customer.first_name
    expect(parsed_customer["attributes"]["last_name"]).to eq customer.last_name
  end

  it "can get all customers with id" do
    customer = create(:customer)
    customer_2 = create(:customer)

    get "/api/v1/customers/find_all?id=#{customer.id}"
    parsed_customers = JSON.parse(response.body)["data"]
    expect(parsed_customers.first["attributes"]["id"]).to eq customer.id
    expect(parsed_customers.first["attributes"]["first_name"]).to eq customer.first_name
    expect(parsed_customers.first["attributes"]["last_name"]).to eq customer.last_name
  end

  it "can get all customers with first_name" do
    customer = create(:customer)
    customer_2 = create(:customer)
    customer_3 = create(:customer, first_name: "different name")

    get "/api/v1/customers/find_all?first_name=#{customer.first_name}"
    parsed_customers = JSON.parse(response.body)["data"]
    expect(parsed_customers.count).to eq 2
    expect(parsed_customers.first["attributes"]["id"]).to eq customer.id
    expect(parsed_customers.first["attributes"]["first_name"]).to eq customer.first_name
    expect(parsed_customers.first["attributes"]["last_name"]).to eq customer.last_name
    expect(parsed_customers.last["attributes"]["id"]).to eq customer_2.id
    expect(parsed_customers.last["attributes"]["first_name"]).to eq customer_2.first_name
    expect(parsed_customers.last["attributes"]["last_name"]).to eq customer_2.last_name
  end

  it "can get all customers with last_name" do
    customer = create(:customer)
    customer_2 = create(:customer)
    customer_3 = create(:customer, last_name: "different name")

    get "/api/v1/customers/find_all?last_name=#{customer.last_name}"
    parsed_customers = JSON.parse(response.body)["data"]
    expect(parsed_customers.count).to eq 2
    expect(parsed_customers.first["attributes"]["id"]).to eq customer.id
    expect(parsed_customers.first["attributes"]["first_name"]).to eq customer.first_name
    expect(parsed_customers.first["attributes"]["last_name"]).to eq customer.last_name
    expect(parsed_customers.last["attributes"]["id"]).to eq customer_2.id
    expect(parsed_customers.last["attributes"]["first_name"]).to eq customer_2.first_name
    expect(parsed_customers.last["attributes"]["last_name"]).to eq customer_2.last_name
  end

  it "can get all customers with created_at" do
    date = "2012-01-01"
    customer = create(:customer, created_at: date)
    customer_2 = create(:customer, created_at: date)
    customer_3 = create(:customer)

    get "/api/v1/customers/find_all?created_at=#{date}"
    parsed_customers = JSON.parse(response.body)["data"]
    expect(parsed_customers.count).to eq 2
    expect(parsed_customers.first["attributes"]["id"]).to eq customer.id
    expect(parsed_customers.first["attributes"]["first_name"]).to eq customer.first_name
    expect(parsed_customers.first["attributes"]["last_name"]).to eq customer.last_name
    expect(parsed_customers.last["attributes"]["id"]).to eq customer_2.id
    expect(parsed_customers.last["attributes"]["first_name"]).to eq customer_2.first_name
    expect(parsed_customers.last["attributes"]["last_name"]).to eq customer_2.last_name
  end

  it "can get all customers with updated_at" do
    date = "2012-01-01"
    customer = create(:customer, updated_at: date)
    customer_2 = create(:customer, updated_at: date)
    customer_3 = create(:customer)

    get "/api/v1/customers/find_all?updated_at=#{date}"
    parsed_customers = JSON.parse(response.body)["data"]
    expect(parsed_customers.count).to eq 2
    expect(parsed_customers.first["attributes"]["id"]).to eq customer.id
    expect(parsed_customers.first["attributes"]["first_name"]).to eq customer.first_name
    expect(parsed_customers.first["attributes"]["last_name"]).to eq customer.last_name
    expect(parsed_customers.last["attributes"]["id"]).to eq customer_2.id
    expect(parsed_customers.last["attributes"]["first_name"]).to eq customer_2.first_name
    expect(parsed_customers.last["attributes"]["last_name"]).to eq customer_2.last_name
  end

  it "can get all of a customer's invoices" do
    merchant = create(:merchant)
    customer = create(:customer)
    customer_2 = create(:customer)
    invoice_1 = create(:invoice, merchant: merchant, customer: customer)
    invoice_2 = create(:invoice, merchant: merchant, customer: customer)
    invoice_3 = create(:invoice, merchant: merchant, customer: customer)
    invoice_4 = create(:invoice, merchant: merchant, customer: customer_2)

    get "/api/v1/customers/#{customer.id}/invoices"
    expect(response).to be_successful
    parsed_invoices = JSON.parse(response.body)["data"]

    expect(parsed_invoices.count).to eq 3
    parsed_invoices.each do |invoice|
      expect(invoice["attributes"]["customer_id"]).to eq customer.id
    end
  end

  it "can get all of a customer's transactions" do
    merchant = create(:merchant)
    customer = create(:customer)
    customer_2 = create(:customer)

    invoice_1 = create(:invoice, customer: customer, merchant: merchant)
    transaction_1 = create(:transaction, invoice: invoice_1)

    invoice_2 = create(:invoice, customer: customer, merchant: merchant)
    transaction_2 = create(:transaction, invoice: invoice_2)

    invoice_3 = create(:invoice, customer: customer, merchant: merchant)
    transaction_3 = create(:transaction, invoice: invoice_3)

    invoice_4 = create(:invoice, customer: customer_2, merchant: merchant)
    transaction_4 = create(:transaction, invoice: invoice_4)

    get "/api/v1/customers/#{customer.id}/transactions"
    expect(response).to be_successful
    parsed_transactions = JSON.parse(response.body)["data"]

    expect(parsed_transactions.count).to eq 3
  end
end
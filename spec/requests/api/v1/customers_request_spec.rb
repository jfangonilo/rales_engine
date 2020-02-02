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

end
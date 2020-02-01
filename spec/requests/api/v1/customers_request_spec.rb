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
end
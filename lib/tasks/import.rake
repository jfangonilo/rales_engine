require 'csv'
require './app/models/application_record.rb'
require './app/models/customer.rb'
require './app/models/merchant.rb'
require './app/models/item.rb'
require './app/models/invoice.rb'
require './app/models/invoice_item.rb'
require './app/models/transaction.rb'

namespace :import do
  desc "import data from CSV"

  task customer_csv: :environment do
    Customer.destroy_all
    customers = CSV.foreach("./data/customers.csv", headers: true, header_converters: :symbol)
    customers.each do |row_data|
      Customer.create(row_data.to_hash)
    end
  end

  task merchant_csv: :environment do
    Merchant.destroy_all
    merchants = CSV.foreach("./data/merchants.csv", headers: true, header_converters: :symbol)
    merchants.each do |row_data|
      Merchant.create(row_data.to_hash)
    end
  end

  task item_csv: :environment do
    Item.destroy_all
    items = CSV.foreach("./data/items.csv", headers: true, header_converters: :symbol)
    items.each do |row_data|
      x = Item.create(row_data.to_hash)
      x.update(unit_price: x.unit_price.to_f/100)
    end
  end

  task invoice_csv: :environment do
    Invoice.destroy_all
    invoices = CSV.foreach("./data/invoices.csv", headers: true, header_converters: :symbol)
    invoices.each do |row_data|
      Invoice.create(row_data.to_hash)
    end
  end

  task invoice_item_csv: :environment do
    InvoiceItem.destroy_all
    invoice_items = CSV.foreach("./data/invoice_items.csv", headers: true, header_converters: :symbol)
    invoice_items.each do |row_data|
      x = InvoiceItem.create(row_data.to_hash)
      x.update(unit_price: x.unit_price.to_f/100)
    end
  end

  task transaction_csv: :environment do
    Transaction.destroy_all
    transactions = CSV.foreach("./data/transactions.csv", headers: true, header_converters: :symbol)
    transactions.each do |row_data|
      Transaction.create(row_data.to_hash)
    end
  end

end
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

  task customers: :environment do
    Customer.destroy_all
    customers = CSV.foreach("./data/customers.csv", headers: true, header_converters: :symbol)
    customers.each do |row|
      Customer.create!({
        id: row[:id],
        first_name: row[:first_name],
        last_name: row[:last_name],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      })
    end
  end

  task merchants: :environment do
    Merchant.destroy_all
    merchants = CSV.foreach("./data/merchants.csv", headers: true, header_converters: :symbol)
    merchants.each do |row|
      Merchant.create!({
        id: row[:id],
        name: row[:name],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      })
    end
  end

  task items: :environment do
    Item.destroy_all
    items = CSV.foreach("./data/items.csv", headers: true, header_converters: :symbol)
    items.each do |row|
      Item.create!({
        id: row[:id],
        name: row[:name],
        description: row[:description],
        unit_price: row[:unit_price].to_f/100,
        merchant_id: row[:merchant_id],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      })
    end
  end

  task invoices: :environment do
    Invoice.destroy_all
    invoices = CSV.foreach("./data/invoices.csv", headers: true, header_converters: :symbol)
    invoices.each do |row|
      Invoice.create!({
        id: row[:id],
        customer_id: row[:customer_id],
        merchant_id: row[:merchant_id],
        status: row[:status],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      })
    end
  end

  task invoice_items: :environment do
    InvoiceItem.destroy_all
    invoice_items = CSV.foreach("./data/invoice_items.csv", headers: true, header_converters: :symbol)
    invoice_items.each do |row|
      InvoiceItem.create!({
        id: row[:id],
        item_id: row[:item_id],
        invoice_id: row[:invoice_id],
        unit_price: row[:unit_price].to_f/100,
        quantity: row[:quantity],
        created_at: row[:created_at],
        updated_at: row[:updated_at],
      })
    end
  end

  task transactions: :environment do
    Transaction.destroy_all
    transactions = CSV.foreach("./data/transactions.csv", headers: true, header_converters: :symbol)
    transactions.each do |row|
      Transaction.create!({
        id: row[:id],
        invoice_id: row[:invoice_id],
        credit_card_number: row[:credit_card_number],
        credit_card_expiration_date: row[:credit_card_expiration_date],
        result: row[:result],
        created_at: row[:created_at],
        updated_at: row[:updated_at]
      })
    end
  end

end
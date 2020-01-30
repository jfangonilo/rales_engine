class ChangeTimestampsToDate < ActiveRecord::Migration[5.1]
  def change
    remove_column :customers, :created_at
    remove_column :invoice_items, :created_at
    remove_column :invoices, :created_at
    remove_column :items, :created_at
    remove_column :merchants, :created_at
    remove_column :transactions, :created_at

    remove_column :customers, :updated_at
    remove_column :invoice_items, :updated_at
    remove_column :invoices, :updated_at
    remove_column :items, :updated_at
    remove_column :merchants, :updated_at
    remove_column :transactions, :updated_at

    add_column :customers, :created_at, :date
    add_column :invoice_items, :created_at, :date
    add_column :invoices, :created_at, :date
    add_column :items, :created_at, :date
    add_column :merchants, :created_at, :date
    add_column :transactions, :created_at, :date

    add_column :customers, :updated_at, :date
    add_column :invoice_items, :updated_at, :date
    add_column :invoices, :updated_at, :date
    add_column :items, :updated_at, :date
    add_column :merchants, :updated_at, :date
    add_column :transactions, :updated_at, :date
  end
end

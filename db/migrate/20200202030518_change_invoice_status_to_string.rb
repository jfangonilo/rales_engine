class ChangeInvoiceStatusToString < ActiveRecord::Migration[5.1]
  def change
    remove_column :invoices, :status

    add_column :invoices, :status, :string
  end
end

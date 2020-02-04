module Api
  module V1
    class InvoiceItemsController < ApplicationController
      def index
        invoice_items = InvoiceItem.search_all(params)
        render json: InvoiceItemSerializer.new(invoice_items)
      end

      def show
        invoice_item = InvoiceItem.search(params)
        render json: InvoiceItemSerializer.new(invoice_item)
      end
    end
  end
end

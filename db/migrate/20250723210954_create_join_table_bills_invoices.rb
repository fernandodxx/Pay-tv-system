class CreateJoinTableBillsInvoices < ActiveRecord::Migration[8.0]
  def change
    create_join_table :bills, :invoices do |t|
      t.index [ :bill_id, :invoice_id ]
      t.index [ :invoice_id, :bill_id ]
    end
  end
end

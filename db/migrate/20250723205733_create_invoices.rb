class CreateInvoices < ActiveRecord::Migration[8.0]
  def change
    create_table :invoices do |t|
      t.references :signature, null: false, foreign_key: true
      t.date :creation_date
      t.date :due_date
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end
  end
end

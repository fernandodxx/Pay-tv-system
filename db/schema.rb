# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_07_23_212552) do
  create_table "additional_services", force: :cascade do |t|
    t.string "name"
    t.decimal "price", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "additional_services_packages", id: false, force: :cascade do |t|
    t.integer "package_id", null: false
    t.integer "additional_service_id", null: false
    t.index ["additional_service_id", "package_id"], name: "idx_on_additional_service_id_package_id_92c01c0079"
    t.index ["package_id", "additional_service_id"], name: "idx_on_package_id_additional_service_id_522bfe430c"
  end

  create_table "additional_services_signatures", id: false, force: :cascade do |t|
    t.integer "signature_id", null: false
    t.integer "additional_service_id", null: false
    t.index ["additional_service_id", "signature_id"], name: "idx_on_additional_service_id_signature_id_183f2f25c2"
    t.index ["signature_id", "additional_service_id"], name: "idx_on_signature_id_additional_service_id_acfdb20c5c"
  end

  create_table "bills", force: :cascade do |t|
    t.integer "signature_id", null: false
    t.date "creation_date"
    t.date "due_date"
    t.decimal "price", precision: 10, scale: 2
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["signature_id"], name: "index_bills_on_signature_id"
  end

  create_table "bills_invoices", id: false, force: :cascade do |t|
    t.integer "bill_id", null: false
    t.integer "invoice_id", null: false
    t.index ["bill_id", "invoice_id"], name: "index_bills_invoices_on_bill_id_and_invoice_id"
    t.index ["invoice_id", "bill_id"], name: "index_bills_invoices_on_invoice_id_and_bill_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "signature_id", null: false
    t.date "creation_date"
    t.date "due_date"
    t.decimal "price", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["signature_id"], name: "index_invoices_on_signature_id"
  end

  create_table "packages", force: :cascade do |t|
    t.string "name"
    t.decimal "price", precision: 8, scale: 2
    t.integer "plan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_packages_on_plan_id"
  end

  create_table "payment_books", force: :cascade do |t|
    t.integer "signature_id", null: false
    t.date "creation_date"
    t.decimal "price", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["signature_id"], name: "index_payment_books_on_signature_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.decimal "price", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "signatures", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "plan_id"
    t.integer "package_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_signatures_on_customer_id"
    t.index ["package_id"], name: "index_signatures_on_package_id"
    t.index ["plan_id"], name: "index_signatures_on_plan_id"
  end

  add_foreign_key "bills", "signatures"
  add_foreign_key "invoices", "signatures"
  add_foreign_key "packages", "plans"
  add_foreign_key "payment_books", "signatures"
  add_foreign_key "signatures", "customers"
  add_foreign_key "signatures", "packages"
  add_foreign_key "signatures", "plans"
end

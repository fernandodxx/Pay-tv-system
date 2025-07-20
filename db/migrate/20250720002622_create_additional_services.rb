class CreateAdditionalServices < ActiveRecord::Migration[8.0]
  def change
    create_table :additional_services do |t|
      t.string :name
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end

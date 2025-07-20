class CreatePackages < ActiveRecord::Migration[8.0]
  def change
    create_table :packages do |t|
      t.string :name
      t.decimal :price, precision: 8, scale: 2
      t.references :plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end

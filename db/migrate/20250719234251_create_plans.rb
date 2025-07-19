class CreatePlans < ActiveRecord::Migration[8.0]
  def change
    create_table :plans do |t|
      t.string :name
      t.decimal :value, precision: 8, scale: 2

      t.timestamps
    end
  end
end

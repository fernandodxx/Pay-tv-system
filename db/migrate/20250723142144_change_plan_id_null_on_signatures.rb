class ChangePlanIdNullOnSignatures < ActiveRecord::Migration[8.0]
  def change
    change_column_null :signatures, :plan_id, true
  end
end

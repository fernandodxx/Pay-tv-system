class ChangePackageIdNullOnSignatures < ActiveRecord::Migration[8.0]
  def change
    change_column_null :signatures, :package_id, true
  end
end

class CreateJoinTablePackagesAdditionalServices < ActiveRecord::Migration[8.0]
  def change
    create_join_table :packages, :additional_services do |t|
      t.index [ :package_id, :additional_service_id ]
      t.index [ :additional_service_id, :package_id ]
    end
  end
end

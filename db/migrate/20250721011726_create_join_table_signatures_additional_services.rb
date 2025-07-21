class CreateJoinTableSignaturesAdditionalServices < ActiveRecord::Migration[8.0]
  def change
    create_join_table :signatures, :additional_services do |t|
      t.index [ :signature_id, :additional_service_id ]
      t.index [ :additional_service_id, :signature_id ]
    end
  end
end

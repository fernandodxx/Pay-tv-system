class Signature < ApplicationRecord
  belongs_to :customer
  belongs_to :plan
  belongs_to :package
  has_and_belongs_to_many :additional_services
end

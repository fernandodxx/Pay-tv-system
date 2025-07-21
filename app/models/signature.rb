class Signature < ApplicationRecord
  belongs_to :customer
  belongs_to :plan
  belongs_to :package
end

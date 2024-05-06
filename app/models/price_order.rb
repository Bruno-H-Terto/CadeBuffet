class PriceOrder < ApplicationRecord
  belongs_to :owner
  belongs_to :order
end

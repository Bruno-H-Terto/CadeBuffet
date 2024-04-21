class Buffet < ApplicationRecord
  belongs_to :owner
  validates :owner_id, uniqueness: true
end

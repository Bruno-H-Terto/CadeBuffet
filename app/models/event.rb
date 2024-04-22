class Event < ApplicationRecord
  belongs_to :owner
  belongs_to :buffet
end

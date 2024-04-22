class Event < ApplicationRecord
  belongs_to :owner
  belongs_to :buffet
  has_one :price_event

  validates :name, :description, :min_quantity_people, :max_quantity_people, :duration_in_minutes, :menu,
             presence: true


end

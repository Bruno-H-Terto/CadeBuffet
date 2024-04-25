class Event < ApplicationRecord
  belongs_to :owner
  belongs_to :buffet
  has_many :price_events
  accepts_nested_attributes_for :price_events
  validates :name, :description, :min_quantity_people, :max_quantity_people, :duration_in_minutes, :menu,
             presence: true


end

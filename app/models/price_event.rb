class PriceEvent < ApplicationRecord
  belongs_to :event
  validates :min_price_working_day, :min_price_weekend,
  :additional_price_for_person_working_day,
  :additional_price_for_person_weekend,
  :extra_hour_working_day,
  :extra_hour_weekend, presence: true

  def price_working_days(min_price, add_people, extra_hour)
    "Valores nos dias úteis: #{min_price} com adicional por pessoa de #{add_people} 
     + Hora extra de R$ #{extra_hour}"
  end

  def price_weekend(min_price, add_people, extra_hour)
    "Valores nos fins de semana: #{min_price} com adicional por pessoa de #{add_people} 
     + Hora extra de R$ #{extra_hour}"
  end
end

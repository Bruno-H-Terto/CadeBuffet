class Event < ApplicationRecord
  belongs_to :owner
  belongs_to :buffet
  has_many :price_events
  has_many :orders
  has_many :price_orders, through: :orders
  accepts_nested_attributes_for :price_events


  validates :name, :description, :min_quantity_people, :max_quantity_people, :duration_in_minutes, :menu,
             presence: true

  validates :max_quantity_people, comparison: { greater_than_or_equal_to: :min_quantity_people }

  def full_description
    "#{name} - #{description}"
  end

  def capacity
    return "Capacidade de #{min_quantity_people} à #{max_quantity_people} pessoas" if max_quantity_people > min_quantity_people
    "Capacidade máxima de #{min_quantity_people} pessoa(s)"
  end

  def duration
    "Duração de #{duration_in_minutes} minutos"
  end

  def menu_description
    "Cardápio: #{menu}"
  end

  def alcoholic?
    return "Bebidas alcoólicas disponíveis" if alcoholic_drink
    "Sem bebida alcoólica"
  end

  def decoration?
    return "Decoração própria" if self_decoration
    "Decoração a parte"
  end

  def parking_space?
    return "Estacionamento disponível" if parking
    "Sem estacionamento"
  end

  def valet_service?
    return "Valet disponível" if valet
    "Sem valet"
  end

  def location?
    return "Local fixo" if fixed_location
    "Local flexível"

  end

  
end

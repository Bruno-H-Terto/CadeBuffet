class Event < ApplicationRecord
  belongs_to :owner
  belongs_to :buffet
  has_many :price_events
  accepts_nested_attributes_for :price_events


  validates :name, :description, :min_quantity_people, :max_quantity_people, :duration_in_minutes, :menu,
             presence: true

  validates :max_quantity_people, comparison: { greater_than_or_equal_to: :min_quantity_people }

  def full_description
    "#{name} - #{description}"
  end

  def capacity
    if max_quantity_people > min_quantity_people
      return "Capacidade de #{min_quantity_people} à #{max_quantity_people} pessoas"
    end
    "Capacidade máxima de #{min_quantity_people} pessoa(s)"
  end

  def duration
    "Duração de #{duration_in_minutes} minutos"
  end

  def menu_description
    "Cardápio: #{menu}"
  end

  def alcoholic?
    if alcoholic_drink
      return "Bebidas alcoólicas disponíveis"
    end
    "Sem bebida alcoólica"
  end

  def decoration?
    if self_decoration
      return "Decoração própria"
    end
    "Decoração a parte"
  end

  def parking_space?
    if parking
      return "Estacionamento disponível"
    end
    "Sem estacionamento"
  end

  def valet_service?
    if valet
      return "Valet disponível"
    end
    "Sem valet"
  end

  def location?
    if fixed_location
      return "Local fixo"
    end
    "Local flexível"

  end
  
end

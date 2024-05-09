class Order < ApplicationRecord
  belongs_to :buffet
  belongs_to :event
  belongs_to :client
  has_one :price_order
  
  before_validation :generate_code, on: :create

  enum status: { waiting_review: 0, confirmed_for_buffet: 1, confirmed: 2, canceled: 3 }

  validates :estimated_date, :estimated_people, :address, :details, presence: true
  validates :estimated_people, numericality: {only_integer: true}
  validate :how_many_people_are_possible?

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def how_many_people_are_possible?
    if estimated_people.present? && estimated_people > event.max_quantity_people
      return errors.add :estimated_people, 'acima da capacidade do evento'
    end
  end

end

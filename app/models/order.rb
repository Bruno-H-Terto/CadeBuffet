class Order < ApplicationRecord
  belongs_to :buffet
  belongs_to :event
  belongs_to :client
  has_many :price_orders
  before_validation :generate_code

  enum status: { waiting_review: 0, confirmed_for_buffet: 1, confirmed: 2, canceled: 3 }

  validates :estimated_date, :estimated_people, :address, :details, presence: true
  validate :how_many_people_are_possible?

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def how_many_people_are_possible?
    return errors.add :estimated_people, 'acima da capacidade do evento' if estimated_people > event.max_quantity_people
  end

end

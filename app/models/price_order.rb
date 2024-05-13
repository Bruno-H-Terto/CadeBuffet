class PriceOrder < ApplicationRecord
  belongs_to :owner
  belongs_to :order
  has_many :events, through: :orders

  validates :initial_price, :rate, :description_rate, :final_price, :payment_methods, :deadline, presence: true
  validates :initial_price, :rate, :final_price, numericality: true
  validate :estimated_date_is_before
  validate :limit_rate


  private
  def estimated_date_is_before
    if order.estimated_date.present? && deadline.present? && deadline > order.estimated_date && deadline >= Date.today
      return errors.add :deadline, 'deve ser anterior a data de realização do evento'
    end
  end

  def limit_rate
    if initial_price.present? && rate.present? && initial_price + rate < 0
      return errors.add :rate, 'não pode ultrapassar o máximo de desconto'
    end
  end

end

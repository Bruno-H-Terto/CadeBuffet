class Order < ApplicationRecord
  belongs_to :buffet
  belongs_to :event
  belongs_to :client
  before_validation :generate_code

  enum status: { waiting_review: 0, confirmed_for_buffet: 1, confirmed: 2, canceled: 3 }

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

end

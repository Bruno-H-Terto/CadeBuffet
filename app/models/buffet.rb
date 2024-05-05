class Buffet < ApplicationRecord
  belongs_to :owner
  has_many :events


  validates :owner_id, uniqueness: true
  validates :brand_name, :corporate_name, :register_number, :phone_number, :address, :district,
            :state, :city, :zip_code, :description, :payment_methods, presence: true  
  validates :register_number, numericality: {only_integer: true}
  validates :phone_number, length: { minimum: 10, maximum: 11 }

  validate :register_number_is_valid

  METHODS = [:pix, :money, :credit_card, :debit_card].freeze
  
  
  def full_register
    "Buffet #{brand_name} | #{corporate_name} CNPJ: #{register_number} | #{mask_phone_number}"
  end

  def full_address
    "Rua: #{address} | Bairro: #{district} | Cidade: #{city} - #{state} | (CEP: #{zip_code})"
  end

  def full_contact
    "Descrição: #{description} | Forma(s) de pagamento(s): #{payment_methods}"
  end
  
  def mask_phone_number
    "(#{phone_number[0..1]}) #{phone_number[2..-1]}"
  end

  private

  def register_number_is_valid
    return errors.add :register_number, 'deve conter 14 digítos' if register_number.nil? || register_number.to_s.length != 14
    if (register_valid_to_eq(register_number.to_s))
      errors.add(:register_number, "não é válido")
    end

  end

  def register_valid_to_eq(register)
    first12 = register[0..11]
    first_dig = digit(calculator(first12)).to_s
    second_dig = digit(calculator(first12 + first_dig)).to_s
    register != first12 + first_dig + second_dig
  end

  def calculator(number)
    i = number.length - 7
    result = 0
    number.each_char do |num|
      result += num.to_i * i
      if i == 2
        i = 10
      end
      i -= 1
    end
    result%11
  end

  def digit(number)
    if number < 2
      return 0
    end
    11 - number
  end
end

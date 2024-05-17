class Buffet < ApplicationRecord
  belongs_to :owner
  has_many :events


  validates :owner_id, uniqueness: true
  validates :brand_name, :corporate_name, :register_number, :phone_number, :address, :district,
            :state, :city, :zip_code, :description, :payment_methods, presence: true  
  validates :register_number, numericality: {only_integer: true}
  validates :phone_number, length: { minimum: 10, maximum: 16 }

  validate :register_number_is_valid?

  METHODS = [:pix, :money, :credit_card, :debit_card]



  
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

  def register_number_is_valid?
    return errors.add :register_number, 'deve conter 14 digítos' if register_number.nil? || register_number.to_s.length != 14
    errors.add(:register_number, "não é válido") unless register_valid_to_eq?(register_number.to_s)

  end

  def register_valid_to_eq?(register)
    first_12_numbers = register[0..11]
    first_digit = digit(digit_calculator(first_12_numbers)).to_s
    second_digit = digit(digit_calculator(first_12_numbers + first_digit)).to_s
    register == first_12_numbers + first_digit + second_digit
  end

  def digit_calculator(number)
    iterator = number.length - 7
    result = 0
    number.each_char do |num|
      result += num.to_i * iterator
      iterator = 10 if iterator == 2
      iterator -= 1
    end
    result%11
  end

  def digit(number)
    return 0 if number < 2
    11 - number
  end



end

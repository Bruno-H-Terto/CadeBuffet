class Client < ApplicationRecord
  has_many :orders

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :register_number, presence: true
  validates :register_number, uniqueness: true
  validates :register_number, numericality: {only_integer: true}

  validate :register_is_valid?, on: :create

  def register_mask
    masked = register_number[0..2] + '.xxx.xxx-' + register_number[9..10]
  end

  private
  def register_is_valid?
    return errors.add :register_number, 'CPF deve conter 11 digítos' if register_number.nil? || register_number.length != 11
    
    errors.add(:register_number, "não é válido") unless (register_valid_to_eq?(register_number))
  end

  def register_valid_to_eq?(register)
    first_9_numbers = register[0..8]
    result = digit_calculator(first_9_numbers)
    
    first_digit = digit_result(result)

    first_10_numbers = first_9_numbers + first_digit
    result = digit_calculator(first_10_numbers)

    second_digit = digit_result(result)

    register == "#{first_10_numbers + second_digit}"
  end

  def digit_calculator(number)
    sum = 0
    i = 9
    number.reverse.each_char do |num|
      sum += num.to_i * i
      i-= 1
    end
    sum%11
  end

  def digit_result(result)
    
    return '0' if result < 2 || result == 10
    
    result.to_s
  end
end

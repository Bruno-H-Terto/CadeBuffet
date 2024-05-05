class Client < ApplicationRecord
  has_many :orders

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :register_number, presence: true
  validates :register_number, uniqueness: true
  validates :register_number, numericality: {only_integer: true}

  validate :register_is_valid

  def register_mask
    masked = register_number[0..2] + '.xxx.xxx-' + register_number[9..10]
  end

  private
  def register_is_valid
    return errors.add :register_number, 'CPF deve conter 11 digítos' if register_number.nil? || register_number.length != 11
    if (register_valid_to_eq(register_number))
      errors.add(:register_number, "não é válido")
    end
  end

  def register_valid_to_eq(register)
    first9 = register[0..8]
    result = calculator(first9)
    
    first_dig = digit(result)

    first10 = first9 + first_dig
    result = calculator(first10)

    second_dig = digit(result)

    register != "#{first10 + second_dig}"
  end
  def calculator(number)
    sum = 0
    i = 9
    number.reverse.each_char do |num|
      sum += num.to_i * i
      i-= 1
    end
    sum%11
  end

  def digit(result)
    if result < 2 || result == 10
      '0'
    else
      result.to_s
    end
  end
end

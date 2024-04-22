class Buffet < ApplicationRecord
  belongs_to :owner
  has_many :event

  validates :owner_id, uniqueness: true
  validates :brand_name, :corporate_name, :register_number, :phone_number, :address, :district,
            :state, :city, :zip_code, :description, :payment_methods, presence: true  
  validates :register_number, numericality: {only_integer: true}
  
  
  def full_register
    "Buffet #{brand_name} - #{corporate_name} #{register_number} - #{phone_number}"
  end

  def full_address
    "Rua: #{address}, Bairro: #{district}, Cidade: #{city} - #{state} (CEP: #{zip_code})"
  end

  def full_contact
    "Descrição #{description} - #{payment_methods}"
  end
end

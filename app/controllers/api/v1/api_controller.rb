class Api::V1::ApiController < ActionController::API
  include ActionView::Helpers::NumberHelper 
  protected

  def message_format(message)
    new_message = ''
    message.each_char do |char|
      new_message << char unless char.to_i.to_s == char
    end
    I18n.t new_message
  end

  def translatedata(event)
    formated_event = event
    formated_event.alcoholic_drink = event.alcoholic?
    formated_event
  end
end
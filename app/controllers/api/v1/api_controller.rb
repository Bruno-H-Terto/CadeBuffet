class Api::V1::ApiController < ActionController::API

  protected

  def message_format(message)
    new_message = ''
    message.each_char do |char|
      new_message << char unless char.to_i.to_s == char
    end
    I18n.t new_message
  end
end
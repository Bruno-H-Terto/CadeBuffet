class Api::V1::EventsController < Api::V1::ApiController
  def index
    begin
      buffet = Buffet.find(params[:buffet_id])
      no_content = {'message' => "Não existem eventos cadastrado para o Buffet: #{buffet.brand_name}"}.to_json
      JSON.parse no_content
      events = Event.where('buffet_id = ?', params[:buffet_id])

      if events.present?
        return render status: 200, json: events.as_json(except: [:created_at, :updated_at]) 
      else
        return render status: 200, json: no_content
      end
    rescue=> error
      no_content = {'message' => "#{message_format(error.to_s)} parâmetros: buffet.id=#{params[:buffet_id]}"}.to_json
      JSON.parse no_content
      render status: 404, json: no_content
    end
  end

  def show
    begin
      event = Event.find(params[:id])
      
      return render status: 200, json: event.as_json(except: [:created_at, :updated_at])
    rescue => error
      no_content = {'message' => "#{message_format(error.to_s)} parâmetros: event.id=#{params[:id]}"}.to_json
      JSON.parse no_content
      render status: 404, json: no_content
    end
  end

  def avaliable_event
    begin
      event = Event.find(params[:id])
      estimated_date = params_event_show[:estimated_date]
      quantity_people = params_event_show[:estimated_quantity_people]

      if estimated_date.present? && quantity_people.present?
        result = availability_event_show(event, estimated_date, quantity_people)
        render status: 200, json: result
      else
        error_message = [{'message' => "Requisição inválida para o evento #{event.name}"},
        {"estimated_date.present?" => "#{estimated_date.present?}"},
        {"estimated_quantity_people.present?" => "#{quantity_people.present?}"}].to_json

        JSON.parse error_message
      
        render status: 404, json: error_message
      end
      
    rescue=> error
      no_content = {'message' => "#{message_format(error.to_s)} parâmetros: event.id=#{params[:id]}"}.to_json
      JSON.parse no_content
      render status: 404, json: no_content
    end
  end


  private

  def availability_event_show(event, estimated_date, quantity_people)
    quantity_people = quantity_people.to_i
    estimated_date = Date.parse estimated_date
    availability = true
    number_order_avaliable_date = 0
    event.orders.confirmed.each do |order|
      if order.estimated_date == estimated_date
        availability = false 
        number_order_avaliable_date += 1
      end
    end
    availability = false if event.min_quantity_people > quantity_people || event.max_quantity_people < quantity_people

    if availability
      date = estimated_date
      json_response = number_to_currency base_price(event, date, quantity_people)
      result = {'base_price_event' => "#{json_response}"}.to_json
      JSON.parse result
      return result
    else
      min_people_params = (event.min_quantity_people <= quantity_people)
      max_people_params = (event.max_quantity_people >= quantity_people)
      available_date = number_order_avaliable_date < 1
      date_format = I18n.l estimated_date


      error_message = [{'message' => "Erro no agendamento para o evento #{event.name}"},
        {"Min. quantity people?" => "#{min_people_params}, quantidade min.: #{event.min_quantity_people}"},
        {"Max. quantity people?" => "#{max_people_params}, quantidade máx.: #{event.max_quantity_people}"},
        {"Estimated date (#{date_format}) available?" => "#{available_date}"}].to_json

      JSON.parse error_message
    end
  end

  def params_event_show
    params.permit(:estimated_date, :estimated_quantity_people)
  end

  def base_price(event, estimated_date, quantity_people)
    price_event = PriceEvent.find_by(event: event)
    is_weekend = (0 == estimated_date.wday || 6 == estimated_date.wday)
    add_people = 0
    add_people = quantity_people - event.min_quantity_people if quantity_people > event.min_quantity_people

    @initial_price = 0
    if is_weekend 
      @initial_price = price_event.min_price_weekend.to_i + price_event.additional_price_for_person_weekend*add_people
    else
      @initial_price = price_event.min_price_working_day.to_i + price_event.additional_price_for_person_working_day*add_people
    end
  end
end
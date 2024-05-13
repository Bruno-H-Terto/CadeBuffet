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
    rescue
      no_content = {'message' => "Sem resultados disponíveis"}.to_json
      JSON.parse no_content
      render status: 404, json: no_content
    end
  end
end
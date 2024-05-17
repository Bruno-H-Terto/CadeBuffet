class Api::V1::BuffetsController < Api::V1::ApiController
  def index
    
    buffets = Buffet.all.order(brand_name: :asc)
    
    if buffet_params[:brand_name].present?
      buffets = buffets.where('brand_name LIKE ?', "#{buffet_params[:brand_name]}%").order(brand_name: :asc)
      no_content = {'message' => "Sem resultados disponíveis para: #{buffet_params[:brand_name]}"}.to_json
      JSON.parse no_content

      
      return render json: no_content, status: 200 if buffets.empty?
    end


    if buffets.present?
      return render json: buffets.as_json(except: [:created_at, :updated_at]), status: 200
    else
      no_content = {'message' => "Sem resultados disponíveis"}.to_json
      JSON.parse no_content
      render json: no_content, status: 204
    end

  end

  def show
    begin
      buffet = Buffet.find(buffet_show_params[:id])
      render status: 200, json: buffet.as_json(except: [:created_at, :updated_at, :corporate_name, :register_number])
    rescue=> error
      no_content = {'message' => "#{message_format(error.to_s)} parâmetros: buffet.id=#{buffet_show_params[:id]}"}.to_json
      JSON.parse no_content
      render status: 404, json: no_content
    end
  end

  private

  def buffet_params
    params.permit(:brand_name)
  end

  def buffet_show_params
    params.permit(:id)
  end
end
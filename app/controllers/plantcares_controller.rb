class PlantcaresController < ApplicationController
  def new
    @plantcare = WteverApi::Plantcare.new
  end

  def create
    @plantcare = WteverApi::Plantcare.new(plantcare_params)
    p 'llego 1'
    if @plantcare.save
      p 'llego 2'
      redirect_to plantcares_path
    else
      p 'llego 3'
      flash.now[:error] = to_flash(@plantcare.response_errors)
      render 'new'
    end
  end

  def index

  end

  def tour

  end

  private
    def plantcare_params
      params.require(:wtever_api_plantcare).permit(
        :name,
        :planted_at)
    end

end

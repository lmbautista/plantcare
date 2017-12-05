class PlantcaresController < ApplicationController
  before_filter  :set_plantcare, only: %w(edit)

  def new
    @plantcare = WteverApi::Plantcare.new
  end

  def create
    @plantcare = WteverApi::Plantcare.new(plantcare_params)

    if @plantcare.save
      flash.now[:notice] = I18n.t('plantcares.create.sucessfully')
      redirect_to plantcares_path
    else
      flash.now[:error] = to_flash(@plantcare.response_errors)
      render 'new'
    end
  end

  def edit
  end

  def update

  end

  def index
    @plantcares = WteverApi::Plantcare.all
  end

  def tour

  end

  private
    def plantcare_params
      params.require(:wtever_api_plantcare).permit(
        :name,
        :planted_at)
    end

    def set_plantcare
      @plantcare = WteverApi::Plantcare.find(params[:id])
    end

end

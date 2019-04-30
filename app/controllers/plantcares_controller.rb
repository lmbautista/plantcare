# Tengo que pasar a los tabs el href, el titulo, si esta activo y el content
# La putada es: lo suyo es configurar todo desde el controller pero el render de
# la vista desde donde narices lo hago?
class PlantcaresController < ApplicationController
  before_action :set_plantcare, only: %w(edit)

  def new
    @plantcare = WteverApi::Plantcare.new
  end

  def create
    binding.pry
    @plantcare = WteverApi::Plantcare.new(plantcare_params)

    if @plantcare.save
      flash[:notice] = I18n.t('plantcares.create.sucessfully')

      redirect_to plantcares_path
    else
      flash[:error] = to_flash(@plantcare.response_errors)

      render 'new'
    end
  end

  def edit
  end

  def update
    @plantcare = WteverApi::Plantcare.new(plantcare_params)

    if @plantcare.save
      flash[:notice] = I18n.t('plantcares.update.sucessfully')

      redirect_to plantcares_path
    else
      flash[:error] = to_flash(@plantcare.response_errors)

      render 'edit'
    end
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
      :planted_at
    ).tap do |whitelist|
      whitelist[:id] = params[:id] if params[:id].present?
      whitelist[:attachments] = params[:wtever_api_plantcare][:attachments]
    end.to_h
  end

  def set_plantcare
    @plantcare = WteverApi::Plantcare.find(params[:id])
  end
end

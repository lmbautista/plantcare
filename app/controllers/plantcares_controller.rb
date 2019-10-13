# frozen_string_literal: true

class PlantcaresController < ApplicationController
  before_action :set_plantcare, only: %w(show edit)

  def index
    @plantcares = WteverApi::Plantcare.all
  end

  def show
  end

  def new
    @plantcare  = WteverApi::Plantcare.new
  end

  def create
    @plantcare  = WteverApi::Plantcare.new(plantcare_params)
    if @plantcare.save
      flash[:notice] = I18n.t("plantcares.create.sucessfully")

      redirect_to plantcares_path
    else
      flash[:error] = to_flash(@plantcare.response_errors)

      render "new"
    end
  end

  def edit
  end

  def update
    @plantcare = WteverApi::Plantcare.new(plantcare_params)

    if @plantcare.save
      flash[:notice] = I18n.t("plantcares.update.sucessfully")

      redirect_to plantcares_path
    else
      flash[:error] = to_flash(@plantcare.response_errors)

      render "edit"
    end
  end

  def tour
  end

  private

  def plantcare_params
    params.require(:wtever_api_plantcare).permit(
      :name,
      :picture,
      :attachments,
      :planted_at
    ).tap do |whitelist|
      whitelist[:id] = params[:id]
      whitelist[:wet_sensor_field] = params.dig(:wtever_api_plantcare, :wet_sensor_field)
      whitelist[:water_pump_field] = params.dig(:wtever_api_plantcare, :water_pump_field)
    end
  end

  def set_plantcare
    @plantcare = WteverApi::Plantcare.find(params[:id])
  end
end

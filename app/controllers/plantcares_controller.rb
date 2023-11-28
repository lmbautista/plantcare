# frozen_string_literal: true

class PlantcaresController < ApplicationController
  before_action :set_plantcare, only: %w(show edit)

  def index
    @plantcares = PlantcareApi::Plantcare.all
  end

  def show
  end

  def new
    @plantcare  = PlantcareApi::Plantcare.new
  end

  def create
    @plantcare  = PlantcareApi::Plantcare.new(plantcare_params)
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
    @plantcare = PlantcareApi::Plantcare.new(plantcare_params)

    if @plantcare.save
      flash[:notice] = I18n.t("plantcares.update.sucessfully")

      redirect_to plantcares_path
    else
      flash[:error] = to_flash(@plantcare.response_errors)

      render "edit"
    end
  end

  def destroy
    plantcare = PlantcareApi::Plantcare.find(params[:id])

    if plantcare.destroy
      flash[:notice] = I18n.t("plantcares.destroy.sucessfully")
    else
      flash[:error] = to_flash(@plantcare.response_errors)
    end

    redirect_to plantcares_path
  end

  private

  def plantcare_params
    params.require(:plantcare_api).permit(
      :name,
      :picture,
      :attachments,
      :planted_at,
      :board_sleep_time,
      :board_watering_interval,
      :board_watering_interval_delay,
      :calibrate_board,
      :configure_board
    ).tap do |permitted_params|
      permitted_params[:id] = params[:id]
      permitted_params[:wet_sensor_field] = params.dig(:plantcare_api, :wet_sensor_field)
      permitted_params[:water_pump_field] = params.dig(:plantcare_api, :water_pump_field)
    end
  end

  def set_plantcare
    @plantcare = PlantcareApi::Plantcare.find(params[:id])
  end
end

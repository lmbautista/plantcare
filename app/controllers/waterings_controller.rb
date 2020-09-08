# frozen_string_literal: true

class WateringsController < ApplicationController
  def new
    @watering = WteverApi::Watering.new(water_pump_id: params[:water_pump_id])
  end

  def create
    watering = WteverApi::Watering.new(watering_params)

    if watering.save
      flash[:notice] = I18n.t("waterings.create.sucessfully")
    else
      flash[:error] = to_flash(@watering.response_errors)
    end

    redirect_to plantcares_path
  end

  def destroy
    plantcare = WteverApi::Watering.find(params[:id])

    if plantcare.destroy
      flash[:notice] = I18n.t("waterings.destroy.sucessfully")
    else
      flash[:error] = to_flash(watering.response_errors)
    end

    redirect_to plantcares_path
  end

  private

  def watering_params
    params
      .require(:wtever_api_watering)
      .permit(
        :water_pump_id,
        :duration_amount,
        :duration_unit,
        :programmed_at,
        :status
      )
  end

  def watering
    @watering ||= WteverApi::Watering.find(params[:id])
  end
end

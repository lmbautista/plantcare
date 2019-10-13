# frozen_string_literal: true

class WaterPumpsController < ApplicationController
  def edit
    water_pump

    respond_to do |format|
      format.js { render :edit }
    end
  end

  def update
    if water_pump.update_with_attributes(water_pump_attributes)
      flash[:notice] = I18n.t("waterpumps.update.sucessfully")
    else
      flash[:error] = to_flash(@water_pump.response_errors)
    end

    respond_to do |format|
      format.js { render :update }
    end
  end

  private

  def water_pump_attributes
    params
      .require(:wtever_api_water_pump)
      .permit(:status)
  end

  def water_pump
    @water_pump ||= WteverApi::WaterPump.find(params[:id])
  end
end

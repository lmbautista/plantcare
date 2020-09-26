# frozen_string_literal: true

class WateringSchedulesController < ApplicationController
  def new
    @watering_schedule = WteverApi::WateringSchedule.new(plantcare_id: params[:plantcare_id])
  end

  def create
    watering_schedule = WteverApi::WateringSchedule.new(watering_schedule_params)

    if watering_schedule.save
      flash[:notice] = I18n.t("watering_schedules.create.sucessfully")
    else
      flash[:error] = to_flash(watering_schedule.response_errors)
    end

    respond_to do |format|
      format.js { render :create }
    end
  end

  def edit
    @watering_schedule = WteverApi::WateringSchedule.find(params[:id])
  end

  def update
    watering_schedule = WteverApi::WateringSchedule.new(watering_schedule_params)

    if watering_schedule.save
      flash[:notice] = I18n.t("watering_schedules.update.sucessfully")
    else
      flash[:error] = to_flash(@watering_schedule.response_errors)
    end

    respond_to do |format|
      format.js { render :update }
    end
  end

  private

  def watering_schedule_params
    params
      .require(:wtever_api_watering_schedule)
      .permit(
        :id,
        :plantcare_id,
        :starts_on,
        :ends_on,
        :status,
        :duration_unit,
        :duration_amount,
        :frequency_unit,
        :frequency_amount
      )
  end

  def watering_schedule
    @watering_schedule ||= WteverApi::WateringSchedule.find(params[:id])
  end
end

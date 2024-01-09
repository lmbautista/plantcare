# frozen_string_literal: true

class WateringsController < ApplicationController
  def new
    @watering = PlantcareApi::Watering.new(water_pump_id: params[:water_pump_id])
  end

  def create
    watering = PlantcareApi::Watering.new(watering_params)

    if watering.save
      flash[:notice] = I18n.t("waterings.create.sucessfully")
    else
      flash[:error] = to_flash(@watering.response_errors)
    end

    redirect_to plantcares_path
  end

  def destroy
    plantcare = PlantcareApi::Watering.find(params[:id])

    if plantcare.destroy
      flash[:notice] = I18n.t("waterings.destroy.sucessfully")
    else
      flash[:error] = to_flash(watering.response_errors)
    end

    redirect_to plantcares_path
  end

  def index
    waterings = PlantcareApi::Watering
      .all(board_id: board_id, page: page, per_page: per_page)

    @paginated_waterings = PlantcareApi::PaginatedCollection
      .new(waterings, waterings.metadata)

    respond_to do |format|
      format.js { render :index }
    end
  end

  private

  DEFAULT_PER_PAGE = 10
  DEFAULT_PAGE = 1

  def index_params
    params.permit(:page, :per_page, :board_id).to_h
  end

  def board_id
    index_params.fetch(:board_id, nil)
  end

  def per_page
    index_params.fetch(:per_page, DEFAULT_PER_PAGE).to_i
  end

  def page
    index_params.fetch(:page, DEFAULT_PAGE).to_i
  end

  def watering_params
    params
      .require(:plantcare_api_watering)
      .permit(
        :water_pump_id,
        :duration_amount,
        :duration_unit,
        :programmed_at,
        :status
      )
  end

  def watering
    @watering ||= PlantcareApi::Watering.find(params[:id])
  end
end

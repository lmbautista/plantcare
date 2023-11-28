# frozen_string_literal: true

class BoardConnectionsController < ApplicationController
  def index
    @board_connections = PlantcareApi::BoardConnection
      .all(board_id: board_id, page: page, per_page: per_page)

    respond_to do |format|
      format.js { render :index }
    end
  end

  private

  DEFAULT_PER_PAGE = 15
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
end

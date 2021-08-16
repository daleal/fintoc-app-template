class Api::LinksController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def create
    @link = Link.find_or_initialize_by(fintoc_id: link_params[:id])
    @link.fintoc_token = link_params[:link_token]
    if @link.save
      render json: @link
    else
      render json: { message: 'Internal server error' }, status: 500
    end
  end

  private

    def link_params
      params.require(:data).permit(:id, :link_token)
    end

end

class Api::AccountsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def index
    link = GetLink.for link_id: accounts_params[:link_id]
    accounts = link.accounts.map do |acc|
      {
        id: acc.id,
        name: "#{acc.name} #{acc.number}",
        balance: {
          available: acc.balance.available,
          current: acc.balance.current,
          limit: acc.balance.limit
        }
      }
    end
    render json: accounts
  end

  private

    def accounts_params
      params.permit(:link_id)
    end

end

class Api::MovementsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def index
    link = GetLink.for link_id: movements_params[:link_id]
    account = link.find(id: params[:account_id])
    movements = account.get_movements.map do |mov|
      {
        id: mov.id,
        amount: mov.amount,
        currency: mov.currency,
        description: mov.description,
        post_date: mov.post_date,
        transaction_date: mov.transaction_date,
        type: mov.type,
        reference_id: mov.reference_id,
        recipient_account: mov.recipient_account ? {
          holder_id: mov.recipient_account.holder_id,
          holder_name: mov.recipient_account.holder_name,
          number: mov.recipient_account.number,
          institution: mov.recipient_account.institution ? {
            id: mov.recipient_account.institution.id,
            name: mov.recipient_account.institution.name,
            country: mov.recipient_account.institution.country,
          } : nil
        } : nil,
        sender_account: mov.sender_account ? {
          holder_id: mov.sender_account.holder_id,
          holder_name: mov.sender_account.holder_name,
          number: mov.sender_account.number,
          institution: mov.sender_account.institution ? {
            id: mov.sender_account.institution.id,
            name: mov.sender_account.institution.name,
            country: mov.sender_account.institution.country,
          } : nil
        } : nil,
        comment: mov.comment
      }
    end
    render json: movements
  end

  private

    def movements_params
      params.permit(:link_id)
    end

end

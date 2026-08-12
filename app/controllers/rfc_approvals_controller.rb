class RfcApprovalsController < ApplicationController
  def create
    command_bus.call(
      Guidelines::ApproveByDeveloper.new(
        tid: params[:rfc_id],
        developer_id: params.require(:developer_id)
      )
    )
    render json: { status: "accepted" }, status: :accepted
  end
end

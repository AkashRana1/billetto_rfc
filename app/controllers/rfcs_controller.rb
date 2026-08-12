class RfcsController < ApplicationController
  def create
    command_bus.call(
      Guidelines::IssueRequestForComment.new(
        description: params.require(:description),
        developer_id: params.require(:developer_id)
      )
    )
    render json: { status: "accepted" }, status: :accepted
  end

  def show
    rfc = ObjectRepository.find(params[:id])
    render json: { id: rfc.tid, number: rfc.number, description: rfc.description, author_id: rfc.author_id }
  rescue ActiveRecord::RecordNotFound
    render json: { error: "RFC not found" }, status: :not_found
  end
end

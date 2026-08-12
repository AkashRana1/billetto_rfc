class IncomingWebhooksController < ApplicationController
  def create
    payload = JSON.parse(request.body.read, symbolize_names: true)
    webhook = IncomingWebhook.create!(service: params[:service], data: payload.to_h)
    SomeServiceWebhookJob.perform_async(webhook.id)
    head :accepted
  rescue JSON::ParserError => e
    Rails.logger.warn("Invalid webhook payload: #{e.message}")
    head :bad_request
  end
end

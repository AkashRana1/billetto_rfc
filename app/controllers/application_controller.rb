class ApplicationController < ActionController::API
  private

  def command_bus
    @command_bus ||= Command::Bus.new
  end
end

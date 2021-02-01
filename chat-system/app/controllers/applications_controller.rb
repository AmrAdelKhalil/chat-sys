class ApplicationsController < ApplicationController

  before_action :set_application, except: %i[create]

  def create
    result = ApplicationServices::Create.call(application_params)
    if result.success?
      render json: result.object, status: :created
    else
      render json: errors_msg(result.object), status: :unprocessable_entity
    end
  end

  def update
    result = ApplicationServices::Update.call(@application, application_params)
    if result.success?
      render json: result.object, status: :ok
    else
      render json: errors_msg(result.object), status: :unprocessable_entity
    end
  end

  def show
    render json: @application, status: :ok
  end

  private

  def application_params
    params.require(:application).permit(:desc)
  end

  def set_application
    @application = Application.find_by!(token: senitize_param(params[:token]))
  end
end

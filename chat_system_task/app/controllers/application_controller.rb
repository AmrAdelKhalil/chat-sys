class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  private

  def errors_msg(object)
    {messages: object.errors.full_messages}
  end

  def not_found_response
    render json: {messages: [I18n.t('active_record.exceptions.not_found')]}, status: :unprocessable_entity
  end

  def senitize_param(input)
    ActiveRecord::Base::sanitize_sql(input)
  end
end

module ApplicationServices
  class Create < ServicesBase
    def self.call(application_params)
      application = Application.new(application_params)
      if application.save
        Result.new(object: application, success: true)
      else
        Result.new(object: application, success: false)
      end
    end
  end
end
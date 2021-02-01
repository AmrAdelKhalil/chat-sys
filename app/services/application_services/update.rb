module ApplicationServices
  class Update < ServicesBase
    def self.call(app, application_params)
      if app.update(application_params)
        Result.new(object: app, success: true)
      else
        Result.new(object: app, success: false)
      end
    end
  end
end
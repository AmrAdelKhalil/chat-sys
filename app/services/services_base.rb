class ServicesBase
  private

  class Result
    attr_reader :object, :success
    def initialize(object: , success:)
      @object = object
      @success = success
    end

    def success?
      success
    end
  end
end
module ServiceResponse
  class Success
    attr_accessor :object

    def initialize(object)
      @object = object
    end

    def success?; true; end
  end

  class Error
    attr_accessor :error

    def initialize(error)
      @error = error
    end

    def success?; false; end

    def message
      error.message
    end
  end
end

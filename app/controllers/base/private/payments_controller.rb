module Base
  module Private
    class PaymentsController < Private::BaseController
      def index
        @payments = []
      end
    end
  end
end

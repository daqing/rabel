module Rabel
  module ControllerMatchers
    class ExtendTheController
      def initialize(expected)
        @expected = expected
      end

      def matches?(actual)
        @actual_class = actual.class
        @actual_class.superclass == @expected
      end

      def failure_message_for_should
        "Expected controller #{@actual_class.inspect} to extend #{@expected.inspect}, but was #{@actual_class.superclass.inspect}"
      end

      def failure_message_for_should_not
        "Expected controller #{@actual_class.inspect} *NOT* to extend #{@expected.inspect}"
      end
    end

    def extend_the_controller(expected)
      ExtendTheController.new(expected)
    end
  end
end

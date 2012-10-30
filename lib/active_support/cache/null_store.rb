module ActiveSupport
  module Cache
    class NullStore < Store
      def read(key)
        nil
      end

      def fetch(key, options={})
        yield
      end

      def delete(key)
        true
      end

      def clear
        true
      end

      def write(key, value)
        true
      end

      def increment(key, value=1, options={})
        true
      end
    end
  end
end


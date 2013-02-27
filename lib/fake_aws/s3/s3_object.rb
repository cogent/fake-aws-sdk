module FakeAWS
  class S3

    class S3Object

      def initialize(key)
        @key = key
      end

      attr_reader :key

      def write(data)
        data = data.read if data.respond_to?(:read)
        @data = data
      end

      def read
        must_exist!
        if block_given?
          @data.each_line do |line|
            yield line
          end
        end
        @data
      end

      def content_length
        must_exist!
        @data.length
      end

      def exists?
        !!@data
      end

      def delete
        @data = nil
      end

      private

      def must_exist!
        raise KeyError unless exists?
      end

    end

  end
end

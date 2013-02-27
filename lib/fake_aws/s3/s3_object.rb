module FakeAWS
  class S3

    class S3Object

      def initialize(bucket, key)
        @bucket = bucket
        @key = key
      end

      attr_reader :bucket
      attr_reader :key

      def write(data)
        data = data.read if data.respond_to?(:read)
        @data = data
      end

      def read
        must_exist!
        @data
      end

      def content_length
        must_exist!
        @data.length
      end

      def exists?
        !!@data
      end

      private

      def must_exist!
        raise KeyError unless exists?
      end

    end

  end
end

module FakeAWS
  module S3

    class S3Object

      def initialize(bucket, key)
        @bucket = bucket
        @key = key
      end

      attr_reader :bucket
      attr_reader :key

      # def write(data)
      #   data = data.read if data.respond_to?(:read)
      #   @data = data
      # end

      # def read
      #   @data
      # end

      # def content_length
      #   @data.length
      # end

      # def exists?
      #   !!@data
      # end

    end

  end
end

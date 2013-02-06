require "fake-aws/s3/s3_object"

module FakeAWS
  module S3

    class Bucket

      def initialize(name)
        @name = name
        @objects = Hash.new do |h, key|
          h[key] = S3Object.new(self, key)
        end
      end

      attr_reader :name
      attr_reader :objects

    end

  end

end

require "fake_aws/s3/s3_object"
require "forwardable"

module FakeAWS
  module S3

    class ObjectCollection

      def initialize(bucket)
        @bucket = bucket
        @objects = Hash.new do |h, key|
          h[key] = S3Object.new(self, key)
        end
      end

      def [](key)
        key = key.to_s
        @objects[key]
      end

      extend Forwardable

      def_delegators :@objects, :count

    end

  end
end

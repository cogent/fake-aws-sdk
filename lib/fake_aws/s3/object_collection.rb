require "fake_aws/s3/s3_object"
require "forwardable"

module FakeAWS
  class S3

    class ObjectCollection

      def initialize
        @objects = Hash.new do |h, key|
          h[key] = S3Object.new(key)
        end
      end

      def [](key)
        key = key.to_s
        @objects[key]
      end

      extend Forwardable

      def_delegators :@objects, :empty?

    end

  end
end

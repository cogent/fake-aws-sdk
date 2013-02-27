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

      include Enumerable

      def each
        @objects.each_value do |object|
          yield object if object.exists?
        end
      end

      def empty?
        !@objects.values.any?(&:exists?)
      end

    end

  end
end

require "fake_aws/s3/s3_object"
require "forwardable"

module FakeAWS
  class S3

    class ObjectCollection

      def initialize(bucket)
        @bucket = bucket
        @objects = Hash.new do |h, key|
          h[key] = S3Object.new(bucket, key)
        end
      end

      def [](key)
        key = key.to_s
        @objects[key]
      end

      include Enumerable

      def each(&block)
        @objects.values.select(&:exists?).sort_by(&:key).each(&block)
      end

      def empty?
        !@objects.values.any?(&:exists?)
      end

    end

  end
end

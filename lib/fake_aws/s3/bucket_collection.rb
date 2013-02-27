require "fake_aws/s3/bucket"

module FakeAWS
  class S3

    class BucketCollection

      def initialize
        @buckets = Hash.new do |h, name|
          h[name] = Bucket.new(name)
        end
      end

      def [](name)
        name = name.to_s
        @buckets[name]
      end

      include Enumerable

      def each(&block)
        @buckets.each_value(&block)
      end

    end

  end
end

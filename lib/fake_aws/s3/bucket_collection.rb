require "fake_aws/s3/bucket"
require "forwardable"

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

      extend Forwardable

      def_delegators :@buckets, :empty?

    end

  end
end

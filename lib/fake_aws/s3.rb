require "fake_aws/s3/bucket_collection"
require "fake_aws/s3/s3_object"

module FakeAWS

  class S3

    def initialize(options = {})
      @options = options
      @buckets = BucketCollection.new(self)
    end

    attr_reader :buckets
    attr_reader :options

  end

end
